//
//  detailViewController.swift
//  placeSearch
//
//  Created by Pollinion User on 16/04/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit
import MapKit

class detailViewController: UIViewController {

    @IBOutlet weak var btnSave: UIBarButtonItem!
    @IBOutlet weak var btnShow: UIBarButtonItem!
    
    @IBOutlet weak var toolbarRoute: UIToolbar!
    @IBOutlet weak var titleRoute: UITextField!
    @IBOutlet weak var descriptionRoute: UITextView!
    
    var route : Route? = nil
    var favoritePoints : [MKMapItem] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Detail of Route"
        self.descriptionRoute.editable = false
        if (route != nil){
            print("load Route")
            showDatadetail(self.route!)
            self.titleRoute.enabled = false
            self.btnSave.enabled = false
        }
        else{
            print("new Route")
            self.btnShow.enabled = false
            self.showFavoritePoints(self.favoritePoints)
        }
    }
    
    // Set dates of route
    func showDatadetail(route :Route){
        self.titleRoute.text = route.name
        self.showFavoritePoints(route.points)

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
        
    }
    
    @IBAction func btnSaveRoute(sender: AnyObject) {
        if (self.titleRoute.text != ""){
            let newRoute =  Route(name: "\(self.titleRoute.text!)", description: "Detalle", points: self.favoritePoints, image: nil)
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
    
    func saveRouteAction(route : Route) {
        dispatch_async(dispatch_get_main_queue()) {
            //perform code
            let nextViewController = self.storyboard?.instantiateViewControllerWithIdentifier("tableViewController") as? tableViewController
            nextViewController!.newRoute = route
            self.navigationController?.pushViewController(nextViewController!, animated: true)
        }
    }
    
    @IBAction func btnSaveRoute() {
        navigationController?.popToRootViewControllerAnimated(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
