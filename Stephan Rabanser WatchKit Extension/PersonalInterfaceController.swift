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
    
    //MARK: InterfaceController lifecycle
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        avatarImage.setImage(UIImage(named: "Me"))
        nameLabel.setText("Stephan Rabanser")
        descriptionLabel.setText("Computer science student, Developer, Tech and USA lover")
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
}
