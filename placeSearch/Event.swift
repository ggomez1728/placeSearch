//
//  Event.swift
//  placeSearch
//
//  Created by Pollinion User on 29/04/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit

class Event: NSObject {
    var date : String
    var name : String
    var descriptionEvent : String
    var image : String
    init(date:String, name: String, description:String, image: String) {
        self.date = date
        self.name = name
        self.descriptionEvent = description
        self.image = image
    }
}
