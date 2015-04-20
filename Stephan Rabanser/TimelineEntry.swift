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
    
    var title: String!
    var shortDescription: String!
    var longDescription: String!
    var date: String!
    var type: TimelineEntryType!
    var imageString: String!
    var image: UIImage!
    
    // MARK: - Constructor
    
    init(title: String, shortDescription: String, description: String, date: String, type: TimelineEntryType, imageString: String) {
        self.title = title
        self.shortDescription = shortDescription
        self.longDescription = description
        self.date = date
        self.type = type
        self.imageString = imageString
        self.image = UIImage(named: imageString)
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
