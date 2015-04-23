//
//  DetailInterfaceController.swift
//  Stephan Rabanser
//
//  Created by Stephan Rabanser on 23/04/15.
//  Copyright (c) 2015 Stephan Rabanser. All rights reserved.
//

import Foundation
import WatchKit

class DetailInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var headlineLabel: WKInterfaceLabel!
    @IBOutlet weak var shortDescriptionLabel: WKInterfaceLabel!
    @IBOutlet weak var dateLabel: WKInterfaceLabel!
    
    var entry: TimelineEntry!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        entry = context as! TimelineEntry
        headlineLabel.setText(entry.title)
        headlineLabel.setTextColor(UIColor.colorForType(entry.type))
        shortDescriptionLabel.setText(entry.shortDescription)
        dateLabel.setText(entry.date)
        // Configure interface objects here.
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
