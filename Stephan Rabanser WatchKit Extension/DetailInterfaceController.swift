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
    
    var entry: Entry!
    
    // MARK: - InterfaceController lifecycle
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        entry = context as! Entry
        
        setupDetailView()
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    // MARK: Custom functions
    
    func setupDetailView() {
        headlineLabel.setText(entry.title)
        headlineLabel.setTextColor(UIColor.colorForType(entry.type))
        shortDescriptionLabel.setText(entry.shortDescription)
        dateLabel.setText(entry.date)
    }
    
}
