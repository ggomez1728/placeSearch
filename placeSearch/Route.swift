//
//  Route.swift
//  placeSearch
//
//  Created by Pollinion User on 16/04/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import Foundation
import UIKit
import MapKit

struct Route {
    var name : String
    var Description : String
    var Points : [MKMapItem]
    var image : UIImage?
    init(name : String, Description : String, Points : [MKMapItem], image : UIImage? ){
        self.name = name
        self.Description = Description
        self.Points = Points
        if (image != nil){
            self.image = image!
        }
    }
}