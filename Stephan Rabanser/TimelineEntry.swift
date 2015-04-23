//
//  TimelineEntry.swift
//  Stephan Rabanser
//
//  Created by Stephan Rabanser on 17/04/15.
//  Copyright (c) 2015 Stephan Rabanser. All rights reserved.
//

import UIKit

enum TimelineEntryType: Int {
    case Personal = 0
    case Education
    case Development
}

@objc(TimelineEntry)
class TimelineEntry: NSObject, Printable, NSCoding {
    
    var title = ""
    var shortDescription = ""
    var longDescription = ""
    var date = ""
    var type = TimelineEntryType.Personal
    var imageString = ""
    var image: UIImage!
    var buttonTitle = ""
    var buttonURL: NSURL!
    
    // MARK: - Constructor
    
    init(title: String, shortDescription: String, description: String, date: String, type: TimelineEntryType, imageString: String, buttonTitle: String, buttonURL: String) {
        self.title = title
        self.shortDescription = shortDescription
        self.longDescription = description
        self.date = date
        self.type = type
        self.imageString = imageString
        self.image = UIImage(named: imageString)
        self.buttonTitle = buttonTitle
        self.buttonURL = NSURL(string: buttonURL)
    }
    
    required init(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObjectForKey("title") as! String
        shortDescription = aDecoder.decodeObjectForKey("shortDescription") as! String
        longDescription = aDecoder.decodeObjectForKey("longDescription") as! String
        date = aDecoder.decodeObjectForKey("date") as! String
        type = TimelineEntryType(rawValue: aDecoder.decodeIntegerForKey("type") as Int)!
        imageString = aDecoder.decodeObjectForKey("imageString") as! String
        image = UIImage(named: imageString)
        imageString = aDecoder.decodeObjectForKey("buttonTitle") as! String
        buttonURL = NSURL(string: aDecoder.decodeObjectForKey("buttonURLString") as! String)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(shortDescription, forKey: "shortDescription")
        aCoder.encodeObject(longDescription, forKey: "longDescription")
        aCoder.encodeObject(date, forKey: "date")
        aCoder.encodeInteger(type.rawValue, forKey: "type")
        aCoder.encodeObject(imageString, forKey: "imageString")
        aCoder.encodeObject(buttonTitle, forKey: "buttonTitle")
        aCoder.encodeObject(buttonURL.absoluteString!, forKey: "buttonURLString")
    }
    
    // MARK: - Printable protocol
    
    override var description: String {
        return "Title: \(title)\nShort description: \(shortDescription)\nDescription: \(description)\nDate: \(date)\nImage named: \(date)"
    }
    
    // MARK: - Functions
    
    func printDescription() -> Void {
        println("==================")
        println(description)
        println("==================")
    }
    
}
