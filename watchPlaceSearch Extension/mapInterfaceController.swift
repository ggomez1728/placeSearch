//
//  mapInterfaceController.swift
//  placeSearch
//
//  Created by Pollinion User on 20/04/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import WatchKit
import Foundation


class mapInterfaceController: WKInterfaceController {

    var point : MKMapItem? = nil
    
    @IBOutlet var mapView: WKInterfaceMap!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        self.point = context as? MKMapItem
        // Configure interface objects here.
        self.addPointInMap(self.point!)
    }
    
    func addPointInMap(point : MKMapItem){
        let tec = CLLocationCoordinate2D( latitude: point.placemark.location!.coordinate.latitude
, longitude: point.placemark.location!.coordinate.longitude)
        self.focusMap(0.005, point: tec)
        self.mapView.addAnnotation(tec, withPinColor: .Green)
    }
    
    @IBAction func zoomView(value: Float) {
        let grades : CLLocationDegrees = CLLocationDegrees(value)/10
        let tec = CLLocationCoordinate2D(latitude: 19.283996, longitude: -99.136006)
        self.focusMap(grades , point: tec)

    }
    
    func focusMap(value: CLLocationDegrees, point : CLLocationCoordinate2D ){
        let grades : CLLocationDegrees = CLLocationDegrees(value)/10
        let windowMap = MKCoordinateSpanMake(grades, grades)
        let region = MKCoordinateRegionMake(point, windowMap)
        mapView.setRegion(region)
    }


    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
