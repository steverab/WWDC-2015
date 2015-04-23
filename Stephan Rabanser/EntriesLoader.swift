//
//  EntriesLoader.swift
//  Stephan Rabanser
//
//  Created by Stephan Rabanser on 23/04/15.
//  Copyright (c) 2015 Stephan Rabanser. All rights reserved.
//

import Foundation

class EntriesLoader: NSObject {
    
    class func loadEntries() -> [TimelineEntry] {
        var entries = [TimelineEntry]()
        let loadedEntries = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("Entries", ofType: "plist")!)
        for dict in loadedEntries ?? [] {
            let buttonDict = dict["button"] as! [String : String]
            let buttonTitle = buttonDict["title"]!
            let entry = TimelineEntry(title: dict["title"] as! String, shortDescription: dict["shortDescription"] as! String, description: dict["description"] as! String, date: dict["date"] as! String, type: TimelineEntryType(rawValue: dict["type"] as! Int)!, imageString: dict["image"] as! String, buttonTitle: buttonDict["title"]!, buttonURL: buttonDict["link"]!)
            entries.append(entry)
        }
        return entries
    }
    
}