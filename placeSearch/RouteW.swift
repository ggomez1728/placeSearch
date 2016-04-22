//
//  RouteW.swift
//  placeSearch
//
//  Created by Pollinion User on 21/04/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import WatchKit

class RouteW: NSObject {
    var name : String
    var favoritePoints : String
    var points : [MKMapItem]
    var image : UIImage?
    init(name : String, description : String, points : [MKMapItem], image : UIImage? ){
        self.name = name
        self.favoritePoints = description
        self.points = points
        if (image != nil){
            self.image = image!
        }
    }
}
