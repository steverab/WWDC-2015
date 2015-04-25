//
//  PersonalInterfaceController.swift
//  Stephan Rabanser
//
//  Created by Stephan Rabanser on 24/04/15.
//  Copyright (c) 2015 Stephan Rabanser. All rights reserved.
//

import Foundation
import WatchKit

class PersonalInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var avatarImage: WKInterfaceImage!
    @IBOutlet weak var nameLabel: WKInterfaceLabel!
    @IBOutlet weak var descriptionLabel: WKInterfaceLabel!
    @IBOutlet weak var emailLabel: WKInterfaceLabel!
    @IBOutlet weak var twitterLabel: WKInterfaceLabel!
    @IBOutlet weak var websiteLabel: WKInterfaceLabel!
    @IBOutlet weak var map: WKInterfaceMap!
    
    // MARK: - InterfaceController lifecycle
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        avatarImage.setImage(UIImage(named: "Me"))
        
        setupMe()
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    // MARK: - Custom functions
    
    func setupMe() {
        WKInterfaceController.openParentApplication(["request": "loadMe"], reply: { (replyInfo, error) -> Void in
            if error != nil {
                println("Error loading me: \(error.description)")
            }
            
            if let meData = replyInfo["meData"] as? NSData {
                if let me = NSKeyedUnarchiver.unarchiveObjectWithData(meData) as? Me {
                    self.nameLabel.setText(me.name)
                    self.descriptionLabel.setText(me.shortDescription)
                    self.emailLabel.setText(me.email)
                    self.twitterLabel.setText(me.twitter)
                    self.websiteLabel.setText(me.website)
                    
                    let location = CLLocationCoordinate2D(latitude: me.locationLatitude, longitude: me.locationLongitude)
                    
                    let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
                    
                    self.map.setRegion(region)
                    
                } else {
                    println("Error converting meData")
                }
            } else {
                println("Error looking up meData")
            }
        })
    }
    
}
