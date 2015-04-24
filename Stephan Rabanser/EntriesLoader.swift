//
//  EntriesLoader.swift
//  Stephan Rabanser
//
//  Created by Stephan Rabanser on 23/04/15.
//  Copyright (c) 2015 Stephan Rabanser. All rights reserved.
//

import Foundation

class EntriesLoader: NSObject {
    
    class func loadTimelineEntries() -> [TimelineEntry] {
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
    
    class func loadMe() -> Me {
        let meDict = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("Me", ofType: "plist")!)!
        return Me(name: meDict["name"] as! String, shortDescription: meDict["description"] as! String, email: meDict["email"] as! String, twitter: meDict["twitter"] as! String, website: meDict["website"] as! String)
    }
    
}