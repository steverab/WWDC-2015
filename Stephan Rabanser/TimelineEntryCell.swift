//
//  TimelineEntryCell.swift
//  Stephan Rabanser
//
//  Created by Stephan Rabanser on 17/04/15.
//  Copyright (c) 2015 Stephan Rabanser. All rights reserved.
//

import UIKit

class TimelineEntryCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var outlineView: OutlineView!
    
    var type: TimelineEntryType = TimelineEntryType.Personal {
        willSet {
            outlineView.contentType = newValue
            titleLabel.textColor = UIColor.colorForType(newValue)
        }
    }
    
}
