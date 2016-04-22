//
//  tableViewController.swift
//  placeSearch
//
//  Created by Pollinion User on 16/04/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit
import CoreData
import WatchConnectivity



class tableViewController: UITableViewController, WCSessionDelegate {
    
    // Our WatchConnectivity Session for communicating with the watchOS app
    var watchSession : WCSession?

    
    private var routes : Array<Route> = Array<Route>()
    var newRoute : Route? = nil
    var numtest : Int = 0

    func doSaveRouteWithData(data: Route) {
        print("Guarda bien")
        // Uses the data passed back
    }
    
    @IBAction func testeooo(sender: AnyObject) {
        self.loadDataWatch()
    }
    
    func loadDataWatch() {
        self.numtest++
        let message : String = "->\(self.numtest)"
            do {
                try watchSession?.updateApplicationContext(
                    ["message" : message]
                )
            } catch let error as NSError {
                NSLog("Updating the context failed: " + error.localizedDescription)
            }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PlaceSearch"
        
        if (newRoute != nil) {
            self.routes.append(newRoute!)
            print("Save new Route")
        }
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
            print("Soporte Watch Conect")
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
        let cell = tableView.dequeueReusableCellWithIdentifier("CellRoute", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.routes[indexPath.row].name
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
