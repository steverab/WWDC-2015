//
//  Me.swift
//  Stephan Rabanser
//
//  Created by Stephan Rabanser on 25/04/15.
//  Copyright (c) 2015 Stephan Rabanser. All rights reserved.
//

import Foundation

@objc(Me)
class Me: NSObject, Printable, NSCoding {
    
    var name = ""
    var shortDescription = ""
    var email = ""
    var twitter = ""
    var website = ""
    
    // MARK: - Constructor
    
    override init() {
    }
    
    init(name: String, shortDescription: String, email: String, twitter: String, website: String) {
        self.name = name
        self.shortDescription = shortDescription
        self.email = email
        self.twitter = twitter
        self.website = website
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as! String
        shortDescription = aDecoder.decodeObjectForKey("shortDescription") as! String
        email = aDecoder.decodeObjectForKey("email") as! String
        twitter = aDecoder.decodeObjectForKey("twitter") as! String
        website = aDecoder.decodeObjectForKey("website") as! String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(shortDescription, forKey: "shortDescription")
        aCoder.encodeObject(email, forKey: "email")
        aCoder.encodeObject(twitter, forKey: "twitter")
        aCoder.encodeObject(website, forKey: "website")
    }
    
    // MARK: - Printable protocol
    
    override var description: String {
        return "Name: \(name)\nShort description: \(shortDescription)\nE-Mail: \(email)\nTwitter: \(twitter)\nWebsite: \(website)"
    }
    
    // MARK: - Custom functions
    
    func printDescription() -> Void {
        println("==================")
        println(description)
        println("==================")
    }
    
}