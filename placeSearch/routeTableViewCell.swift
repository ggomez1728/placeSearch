//
//  routeTableViewCell.swift
//  placeSearch
//
//  Created by Pollinion User on 29/04/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit

class routeTableViewCell: UITableViewCell {

    @IBOutlet weak var routeImage: UIImageView!
    @IBOutlet weak var routeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
