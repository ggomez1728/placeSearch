//
//  mapViewController.swift
//  placeSearch
//
//  Created by Pollinion User on 16/04/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class mapViewController: UIViewController,  MKMapViewDelegate, CLLocationManagerDelegate  {
    
    @IBOutlet weak var mapRoute: MKMapView!
 
    var pointsTemp : [MKMapItem] = []
    
    var locationLatitude:Double?
    var locationLongitude:Double?


    private let myManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Map"
        
        mapRoute.delegate = self
        myManager.delegate = self
        myManager.desiredAccuracy = kCLLocationAccuracyBest
        myManager.requestWhenInUseAuthorization()
        myManager.startUpdatingLocation()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //verifica la autorizacion para ver la localizacion del usuario
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse{
            myManager.startUpdatingLocation()
            mapRoute.showsUserLocation = true
        }
        else{
            myManager.stopUpdatingLocation()
            mapRoute.showsUserLocation = false
        }
    }
    //Actualizacion de la localizacion
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        self.locationLatitude = location.coordinate.latitude
        self.locationLongitude = location.coordinate.longitude
        let pointLocation = CLLocationCoordinate2DMake(self.locationLatitude!, self.locationLongitude! )
        let puntoLugar = MKPlacemark(coordinate: pointLocation, addressDictionary: nil)
        focusPointInMap(MKMapItem(placemark: puntoLugar))
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    

    
    @IBAction func btnNewPoint(sender: AnyObject) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "New favorite point in route", message: "Add New Point:", preferredStyle: .Alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.placeholder = "Name of Point"
        })
        
        //3. Grab the value from the text field, and print it when the user clicks Add Point.
        alert.addAction(UIAlertAction(title: "Add Point", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            if(textField.text != ""){
                self.myManager.stopUpdatingLocation()
                let puntoCoor = CLLocationCoordinate2DMake(self.locationLatitude!, self.locationLongitude!)
                let puntoLugar = MKPlacemark(coordinate: puntoCoor, addressDictionary: nil)
                let origen =  MKMapItem(placemark: puntoLugar)
                origen.name = "\(textField.text!)"
                //Add point
                self.addPoint(origen)
                self.myManager.startUpdatingLocation()
            }
            else{
                let alert = UIAlertController(title: "Invalid Request", message: "You have not filled fields", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
        }))

        alert.addAction(UIAlertAction(title: "Finish Route", style: .Default, handler: { (action) -> Void in
            self.finshRouteAction()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))

        // 4. Present the alert.
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func finshRouteAction() {
        dispatch_async(dispatch_get_main_queue()) {
            //perform code
            let nextViewController = self.storyboard?.instantiateViewControllerWithIdentifier("detailViewController") as? detailViewController
            self.navigationController?.pushViewController(nextViewController!, animated: true)
        }
    }
    
    
    
    //Funfiones para creacion de rutas
    
    func getNewRoute(origen: MKMapItem, destino: MKMapItem){
        let newRequest = MKDirectionsRequest()
        newRequest.source = origen
        newRequest.destination = destino
        newRequest.transportType = .Walking
        let indicaciones = MKDirections(request: newRequest)
        indicaciones.calculateDirectionsWithCompletionHandler({
            (respuesta: MKDirectionsResponse?, error: NSError?) in
            if error != nil{
                print("Error al Optener la ruta")
            }
            else{
                self.ShowNewRoute(respuesta!)
            }
        })
    }
    func focusPointInMap(point : MKMapItem){
        let centro = point.placemark.coordinate
        let region = MKCoordinateRegionMakeWithDistance(centro, 1000, 1000)
        mapRoute.setRegion(region, animated: true)
    }
    
    func ShowNewRoute(respuesta: MKDirectionsResponse){
        for ruta in respuesta.routes{
            mapRoute.addOverlay(ruta.polyline, level: MKOverlayLevel.AboveRoads)
            for paso in ruta.steps{
                print(paso.instructions)
            }
        }
        //let centro = origen.placemark.coordinate
        //let region = MKCoordinateRegionMakeWithDistance(centro, 3000, 3000)
        //mapRoute.setRegion(region, animated: true)
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blueColor()
        renderer.lineWidth = 3.0
        return renderer
    }
    
    func addPoint( punto: MKMapItem){
        let anota = MKPointAnnotation()
        anota.coordinate = punto.placemark.coordinate
        anota.title = punto.name
        mapRoute.addAnnotation(anota)
    }
    
}
