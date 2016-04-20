//
//  detailViewController.swift
//  placeSearch
//
//  Created by Pollinion User on 16/04/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit
import MapKit


class detailViewController: UIViewController, UITextFieldDelegate, DestinationViewControllerDelegate {

    
    @IBOutlet weak var btnAction: UIBarButtonItem!
    @IBOutlet weak var btnShow: UIBarButtonItem!
    @IBOutlet weak var pictureShow: UIImageView!
    
    @IBOutlet weak var toolbarRoute: UIToolbar!
    @IBOutlet weak var titleRoute: UITextField!
    @IBOutlet weak var descriptionRoute: UITextView!
    

    
    
    var route : Route? = nil
    var favoritePoints : [MKMapItem] = []
    var saveButton: Bool = false
    var myImage : UIImage? = nil

    func doSomethingWithData(data: UIImage) {
        // Uses the data passed back
        self.myImage = data
        print("cargo la imagen")
    }
    
    override func viewDidAppear(animated: Bool) {
        if(myImage != nil){
            pictureShow.image = self.myImage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Detail of Route"
        titleRoute.delegate = self
        self.descriptionRoute.editable = false
        if (route != nil){
            print("load Route")
            showDatadetail(self.route!)
            self.btnAction.title = "Show"
            self.saveButton = false
        
        }
        else{
            print("new Route")
            self.btnAction.title = "Save"
            self.showFavoritePoints(self.favoritePoints)
            self.saveButton = true
        }
    }
    

    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        self.titleRoute.resignFirstResponder()
        return true;
    }
    
    
    // Set dates of route
    func showDatadetail(route :Route){
        self.titleRoute.text = route.name
        self.showFavoritePoints(route.points)
        if route.image != nil {
            pictureShow.image = route.image
        }

    }
    
    func showFavoritePoints(points : [MKMapItem]){
        
        var printPoints :String = ""
        for point in points {
            printPoints = printPoints + " - \(point.name!) \n"
        }
        self.descriptionRoute.text = printPoints

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnShowRoute(sender: AnyObject) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Type of transport", message: "What type of transport do you want:", preferredStyle: .Alert)
        
        
        //2. Grab the value from the text field, and print it when the user clicks Add Point.
        
        alert.addAction(UIAlertAction(title: "Walking", style: .Default, handler: { (action) -> Void in
            
        }))
        
        alert.addAction(UIAlertAction(title: "Automobile", style: .Default, handler: { (action) -> Void in
  
        }))
        alert.addAction(UIAlertAction(title: "Transit", style: .Default, handler: { (action) -> Void in
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        // 4. Present the alert.
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func btnSaveRoute(sender: AnyObject) {
        if (self.saveButton == true){
            // Save Route
            if (self.titleRoute.text != ""){
                let newRoute =  Route(name: "\(self.titleRoute.text!)", description: "Detalle", points: self.favoritePoints, image: self.myImage)
                self.saveRouteAction(newRoute)
            }
            else{
                let alert = UIAlertController(title: "Failed", message: "You need feld the name of route", preferredStyle: UIAlertControllerStyle.Alert)
                // add the actions (buttons)
                alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: nil))
                // show the alert
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        else{
            // Show Route
            showRouteAction(self.route!)
        }
        
    }
    
    func saveRouteAction(route : Route) {
        //navigationController?.popToRootViewControllerAnimated(true)
        dispatch_async(dispatch_get_main_queue()) {
            //perform code
            let nextViewController = self.storyboard?.instantiateViewControllerWithIdentifier("tableViewController") as? tableViewController
            nextViewController!.newRoute = route
            self.navigationController?.pushViewController(nextViewController!, animated: true)
        }
}
    
    func showRouteAction(route : Route) {
        dispatch_async(dispatch_get_main_queue()) {
            //perform code
            let nextViewController = self.storyboard?.instantiateViewControllerWithIdentifier("mapViewController") as? mapViewController
            nextViewController!.route = route
            self.navigationController?.pushViewController(nextViewController!, animated: true)
        }
    }
    
    @IBAction func getPicture(sender: AnyObject) {
    
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "idCamera"){
            let destinationViewController = segue.destinationViewController as? cameraViewController
            destinationViewController!.pictureForRoute = true
            destinationViewController!.delegate = self
        }
        
    }


}
