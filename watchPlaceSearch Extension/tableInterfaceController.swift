//
//  tableInterfaceController.swift
//  placeSearch
//
//  Created by Pollinion User on 21/04/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import WatchKit
import Foundation
import MapKit


class tableInterfaceController: WKInterfaceController {

    @IBOutlet var tableView: WKInterfaceTable!
    private var routes : Array<RouteW> = Array<RouteW>()

        
    func loadTestRoutes(){
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

        let newRoute = RouteW(name: "my route", description: "testeo", points: points, image: nil)
        self.routes.append(newRoute)
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        self.loadTestRoutes()
        self.setupTable()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        self.pushControllerWithName("idDetailWk", context: routes[rowIndex])
    }

    func setupTable() {
        tableView.setNumberOfRows(self.routes.count, withRowType: "routeRow")
        for var i = 0; i < self.routes.count; ++i {
            if let row = tableView.rowControllerAtIndex(i) as? RouteRowView {
                row.itemLabel.setText(routes[i].name)
            }
        }
    }
}
