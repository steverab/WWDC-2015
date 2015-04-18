//
//  TimelineEntry.swift
//  Stephan Rabanser
//
//  Created by Stephan Rabanser on 17/04/15.
//  Copyright (c) 2015 Stephan Rabanser. All rights reserved.
//

import Foundation

enum TimelineEntryType: Int {
    case Personal = 0
    case Education
    case Development
}

class TimelineEntry {
    
    var title: String!
    var shortDescription: String!
    var description: String!
    var date: String!
    var type: TimelineEntryType!
    
    // MARK: - Constructor
    
    init(title: String, shortDescription: String, description: String, date: String, type: TimelineEntryType) {
        self.title = title
        self.shortDescription = shortDescription
        self.description = description
        self.date = date
        self.type = type
    }
    
    // MARK: - Functions
    
    func printDescription() -> Void {
        println("==================")
        println("Title: \(title)\nShort description: \(shortDescription)\nDescription: \(description)\nDate: \(date)")
        println("==================")
    }
    
}