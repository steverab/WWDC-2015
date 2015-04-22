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

class TimelineEntry: NSObject, Printable {
    
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
