//
//  SafariActivity.swift
//  Stephan Rabanser
//
//  Created by Stephan Rabanser on 25/04/15.
//  Copyright (c) 2015 Stephan Rabanser. All rights reserved.
//

import Foundation

class SafariActivity: UIActivity {
    
    var url: NSURL!
    
    init(url: NSURL) {
        super.init()
        self.url = url
    }
    
    override func activityType() -> String? {
        return "com.steverab.openSafari"
    }
    
    override func activityTitle() -> String? {
        return "Open in Safari"
    }
    
    override func activityImage() -> UIImage? {
        return UIImage(named: "SafariIcon")
    }
    
    override func canPerformWithActivityItems(activityItems: [AnyObject]) -> Bool {
        return true
    }
    
    override func activityViewController() -> UIViewController? {
        return nil
    }
    
    override func performActivity() {
        UIApplication.sharedApplication().openURL(url)
        activityDidFinish(true)
    }
    
}
