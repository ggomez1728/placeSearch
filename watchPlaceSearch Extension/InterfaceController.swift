//
//  InterfaceController.swift
//  watchPlaceSearch Extension
//
//  Created by Pollinion User on 20/04/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import WatchKit
import Foundation

import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    // Our WatchConnectivity Session for communicating with the iOS app
     var watchSession : WCSession?
    private var routes : Array<RouteW> = Array<RouteW>()

    @IBOutlet var messageLabel: WKInterfaceLabel!
    
    /** Called on the delegate of the receiver. Will be called on startup if an applicationContext is available.
     */
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]){
        dispatch_async(dispatch_get_main_queue()) {
            let name : String = applicationContext["name"] as! String
            print(name)
            //self.routes = data
        }
    }

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        /*
        if(WCSession.isSupported()){
            watchSession = WCSession.defaultSession()
            // Add self as a delegate of the session so we can handle messages
            watchSession!.delegate = self
            watchSession!.activateSession()
        }
        */
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
