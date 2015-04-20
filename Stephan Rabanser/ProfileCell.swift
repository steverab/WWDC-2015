//
//  ProfileCell.swift
//  Stephan Rabanser
//
//  Created by Stephan Rabanser on 20/04/15.
//  Copyright (c) 2015 Stephan Rabanser. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var outlineView: OutlineView!
    
    var type: OutlineViewType = .NoCircle {
        willSet {
            outlineView.type = newValue
        }
    }
    
}
