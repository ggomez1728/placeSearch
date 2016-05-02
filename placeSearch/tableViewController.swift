//
//  tableViewController.swift
//  placeSearch
//
//  Created by Pollinion User on 16/04/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit
import CoreData
import MapKit
import WatchConnectivity



class tableViewController: UITableViewController, WCSessionDelegate {
    
    // Our WatchConnectivity Session for communicating with the watchOS app
    var watchSession : WCSession?

    
    var routes : Array<RouteW> = Array<RouteW>()
    var newRoute : RouteW? = nil
    var context :NSManagedObjectContext? = nil

    func doSaveRouteWithData(data: RouteW) {
        print("Guarda bien")
        // Uses the data passed back
    }
    
    @IBAction func moreTools(sender: AnyObject) {
        // self.loadDataWatch()
        let alertController = UIAlertController(title: "more tools", message: nil, preferredStyle:UIAlertControllerStyle.ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { _ in
            
        }
        alertController.addAction(cancelAction)
        
        let eventsAction = UIAlertAction(title: "Events", style: .Default) { _ in
            
            let nextViewController = self.storyboard?.instantiateViewControllerWithIdentifier("eventsTableViewController") as? eventsTableViewController
            self.navigationController?.pushViewController(nextViewController!, animated: true)
        
        }
        alertController.addAction(eventsAction)
        
        let aboutAction = UIAlertAction(title: "About us", style: .Default) { _ in
            
            let nextViewController = self.storyboard?.instantiateViewControllerWithIdentifier("aboutViewController") as? aboutViewController
            self.navigationController?.pushViewController(nextViewController!, animated: true)
        }
        alertController.addAction(aboutAction)
        self.presentViewController(alertController, animated: true, completion:{ () -> Void in
            //your code here
        })

    }

    
    func loadDataWatch() {
        
        let name : String = (self.routes.first?.name)!
        
            do {
                try watchSession?.updateApplicationContext(
                    ["name" : name]
                )
            } catch let error as NSError {
                NSLog("Updating the context failed: " + error.localizedDescription)
            }
    }
    
    func saveNewRouteCoreData(route: RouteW){
        let routeEntity = NSEntityDescription.entityForName("Route", inManagedObjectContext: self.context!)
        let requestRoute = routeEntity?.managedObjectModel.fetchRequestFromTemplateWithName("reqRoute", substitutionVariables: ["name":route.name])
        do{
            let routeEntity2 = try self.context?.executeFetchRequest(requestRoute!)
            if(routeEntity2?.count>0){
                //ya se almaceno con este nombre
                return
            }
        }
        catch{
            
        }
        //guardar en la base de datos
        let newRouteEntity = NSEntityDescription.insertNewObjectForEntityForName("Route", inManagedObjectContext: self.context!)
        // save elements of nwe route
        newRouteEntity.setValue(route.name, forKey: "name")
        if route.image != nil {
            newRouteEntity.setValue(UIImagePNGRepresentation(route.image!) , forKey: "image")
        }
        newRouteEntity.setValue(createFavoritePointsEntity(route.points), forKey: "has_many")
        do{
            try self.context!.save()
        }
        catch{
            
        }
    }
    
    func createFavoritePointsEntity(points : [MKMapItem])-> Set<NSObject>{
        var entities = Set<NSObject>()
        for point in points{
            let pointEntity = NSEntityDescription.insertNewObjectForEntityForName("Point", inManagedObjectContext: self.context!)
            pointEntity.setValue(point.name, forKey: "name")
            pointEntity.setValue(point.placemark.location!.coordinate.latitude, forKey: "latitude")
            pointEntity.setValue(point.placemark.location!.coordinate.longitude, forKey: "longitude")
            entities.insert(pointEntity)
        }
        return entities
    }
    
    func LoadRoutesCoreData(){
        let routeEntity = NSEntityDescription.entityForName("Route", inManagedObjectContext: self.context!)
        let requestRoutes = routeEntity?.managedObjectModel.fetchRequestTemplateForName("reqRoutes")
        do{
            let routesEntity =  try self.context?.executeFetchRequest(requestRoutes!)
            for readRouteEntity in routesEntity!{
                let name = readRouteEntity.valueForKey("name") as! String
                var image : UIImage? = nil
                if readRouteEntity.valueForKey("image") != nil {
                    image = UIImage(data: readRouteEntity.valueForKey("image") as! NSData)
                }
                
                let pointsEntity = readRouteEntity.valueForKey("has_many") as! Set<NSObject>
                var points = [MKMapItem]()
                for readPointsEntity in pointsEntity{
                    let namePoint = readPointsEntity.valueForKey("name") as! String
                    let latitude = readPointsEntity.valueForKey("latitude") as! Double
                    let longitude = readPointsEntity.valueForKey("longitude") as! Double
                    
                    let pointCoor = CLLocationCoordinate2DMake(latitude, longitude)
                    let pointPlace = MKPlacemark(coordinate: pointCoor, addressDictionary: nil)
                    let newPoint =  MKMapItem(placemark: pointPlace)
                    newPoint.name = namePoint
                    points.append(newPoint)
                    //Falta Agregar los nuevos puntos
                }
                
                let routeRead = RouteW(name: name, description: "algo", points: points, image: image)
                
                
                self.routes.append(routeRead)
            }
        }
        catch{
            
        }
    }
    
    func testSaveData(){
        
        var points : [MKMapItem] = []
        var point: MKMapItem!
        
        var puntoCoor = CLLocationCoordinate2DMake(19.359727, -99.257700)
        var puntoLugar = MKPlacemark(coordinate: puntoCoor, addressDictionary: nil)
        point =  MKMapItem(placemark: puntoLugar)
        point.name = "Tecnologico de Monterrey"
        points.append(point)
        
        puntoCoor = CLLocationCoordinate2DMake(19.362896, -99.268856)
        puntoLugar =  MKPlacemark(coordinate: puntoCoor, addressDictionary: nil)
        point = MKMapItem(placemark: puntoLugar)
        point.name = "Centro Comercial"
        points.append(point)
        
        puntoCoor = CLLocationCoordinate2DMake(19.358543, -99.276304)
        puntoLugar = MKPlacemark(coordinate: puntoCoor, addressDictionary: nil)
        point = MKMapItem(placemark: puntoLugar)
        point.name = "Glorieta"
        points.append(point)
        
        let testRoute = RouteW(name: "second Route", description: "test", points: points, image: nil)
        self.saveNewRouteCoreData(testRoute)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PlaceSearch"
        
        self.context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        //self.testSaveData()

        if (newRoute != nil) {
            
            //self.routes.append(newRoute!)
            self.saveNewRouteCoreData(newRoute!)

            print("Save new Route")
        }
        self.LoadRoutesCoreData()

        /*
        * If this device can support a WatchConnectivity session,
        * obtain a session and activate.
        *
        * It isn't usually recommended to put this in viewDidLoad, as the session
        * may not start in the case of starting in the background. We're doing it
        * here to keep this example simple.
        *
        * Note that even though we won't be receiving messages in the View Controller,
        * we still need to supply a delegate to activate the session
        */
        if(WCSession.isSupported()){
            watchSession = WCSession.defaultSession()
            watchSession!.delegate = self
            watchSession!.activateSession()
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.routes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("routeTableViewCell", forIndexPath: indexPath) as! routeTableViewCell

        // Configure the cell...
        cell.routeName?.text = self.routes[indexPath.row].name
        if self.routes[indexPath.row].image != nil {
            cell.routeImage?.image = self.routes[indexPath.row].image
        }
        
        //cell.textLabel?.text = self.routes[indexPath.row].name
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "idDetail"){
            let cc = segue.destinationViewController as! detailViewController
            let ip = self.tableView.indexPathForSelectedRow
            cc.route = self.routes[ip!.row]
        }
    }
    
}
