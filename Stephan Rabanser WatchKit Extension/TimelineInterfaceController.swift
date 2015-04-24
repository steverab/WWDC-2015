//
//  TimelineInterfaceController.swift
//  Stephan Rabanser
//
//  Created by Stephan Rabanser on 23/04/15.
//  Copyright (c) 2015 Stephan Rabanser. All rights reserved.
//

import Foundation
import WatchKit

class EntryRowController: NSObject {
    @IBOutlet weak var headlineLabel: WKInterfaceLabel!
    @IBOutlet weak var colorImage: WKInterfaceImage!
}

class TimelineInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var tableView: WKInterfaceTable!
    @IBOutlet weak var nameLabel: WKInterfaceLabel!
    @IBOutlet weak var avatarButton: WKInterfaceButton!
    
    var entries = [TimelineEntry]()
    
    // MARK: - InterfaceController lifecycle
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        nameLabel.setText("Stephan Rabanser")
        avatarButton.setBackgroundImage(UIImage(named: "Me"))
        
        setupTableView()
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    // MARK: - Custom functions
    
    func setupTableView() {
        WKInterfaceController.openParentApplication(["request": "loadEntries"],
            reply: { (replyInfo, error) -> Void in
                if error != nil {
                    println("Error: \(error.description)")
                }
                
                if let entriesData = replyInfo["entriesData"] as? NSData {
                    if let entries = NSKeyedUnarchiver.unarchiveObjectWithData(entriesData) as? [TimelineEntry] {
                        self.entries = entries
                        self.tableView.setNumberOfRows(self.entries.count, withRowType: "entriesRowType")
                        for (index, entry) in enumerate(self.entries) {
                            let rowController = self.tableView.rowControllerAtIndex(index) as! EntryRowController
                            rowController.headlineLabel.setText(entry.title)
                            if entry.type == .Personal {
                                rowController.colorImage.setImage(UIImage(named: "Green")?.resizableImageWithCapInsets(UIEdgeInsetsMake(2, 2, 2, 2)))
                            } else if entry.type == .Education {
                                rowController.colorImage.setImage(UIImage(named: "Red")?.resizableImageWithCapInsets(UIEdgeInsetsMake(2, 2, 2, 2)))
                            } else {
                                rowController.colorImage.setImage(UIImage(named: "Blue")?.resizableImageWithCapInsets(UIEdgeInsetsMake(2, 2, 2, 2)))
                            }
                            
                        }
                    }
                }
        })
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        if segueIdentifier == "pushDetail" {
            return entries[rowIndex]
        }
        return nil
    }
    
}
