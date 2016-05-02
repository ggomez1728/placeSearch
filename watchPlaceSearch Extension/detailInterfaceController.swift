//
//  detailInterfaceController.swift
//  placeSearch
//
//  Created by Pollinion User on 21/04/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import WatchKit
import Foundation


class detailInterfaceController: WKInterfaceController {
    private var route : RouteW? = nil

    @IBOutlet var tableView: WKInterfaceTable!
    @IBOutlet var nameRoute: WKInterfaceLabel!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
        self.route = context as? RouteW
        self.loadDataDetail(self.route!)
    }
    
    func loadDataDetail(route: RouteW){
        self.nameRoute.setText("\(route.name)")
        self.setupTable(route.points)
    }
    
    func setupTable(points: [MKMapItem]) {
        self.tableView.setNumberOfRows(points.count, withRowType: "pointRow")
        for var i = 0; i < self.route!.points.count; ++i {
            if let row = self.tableView.rowControllerAtIndex(i) as? PointRowView {
                row.itemLabel.setText(points[i].name!)
            }
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        self.pushControllerWithName("idMap", context: route?.points[rowIndex])
    }

}
