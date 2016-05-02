//
//  eventTableViewCell.swift
//  placeSearch
//
//  Created by Pollinion User on 28/04/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit

class eventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateEvent: UILabel!
    @IBOutlet weak var nameEvent: UILabel!
    @IBOutlet weak var contentEvent: UILabel!
    @IBOutlet weak var pictureEvent: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
