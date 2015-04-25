//
//  Me.swift
//  Stephan Rabanser
//
//  Created by Stephan Rabanser on 25/04/15.
//  Copyright (c) 2015 Stephan Rabanser. All rights reserved.
//

import UIKit
import MapKit

@objc(Me)
class Me: NSObject, Printable, NSCoding {
    
    var name = ""
    var shortDescription = ""
    var email = ""
    var twitter = ""
    var website = ""
    var locationLatitude: CLLocationDegrees = 0.0
    var locationLongitude: CLLocationDegrees = 0.0
    
    // MARK: - Constructor
    
    override init() {
    }
    
    init(name: String, shortDescription: String, email: String, twitter: String, website: String, locationLatitude: CLLocationDegrees, locationLongitude: CLLocationDegrees) {
        self.name = name
        self.shortDescription = shortDescription
        self.email = email
        self.twitter = twitter
        self.website = website
        self.locationLatitude = locationLatitude
        self.locationLongitude = locationLongitude
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as! String
        shortDescription = aDecoder.decodeObjectForKey("shortDescription") as! String
        email = aDecoder.decodeObjectForKey("email") as! String
        twitter = aDecoder.decodeObjectForKey("twitter") as! String
        website = aDecoder.decodeObjectForKey("website") as! String
        locationLatitude = CLLocationDegrees(aDecoder.decodeFloatForKey("locationLatitude") as Float)
        locationLongitude = CLLocationDegrees(aDecoder.decodeFloatForKey("locationLongitude") as Float)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(shortDescription, forKey: "shortDescription")
        aCoder.encodeObject(email, forKey: "email")
        aCoder.encodeObject(twitter, forKey: "twitter")
        aCoder.encodeObject(website, forKey: "website")
        aCoder.encodeFloat(Float(locationLatitude), forKey: "locationLatitude")
        aCoder.encodeFloat(Float(locationLongitude), forKey: "locationLongitude")
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