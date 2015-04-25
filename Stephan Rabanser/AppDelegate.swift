//
//  AppDelegate.swift
//  Stephan Rabanser
//
//  Created by Stephan Rabanser on 17/04/15.
//  Copyright (c) 2015 Stephan Rabanser. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // MARK: - Application lifecycle

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        NSUserDefaults.standardUserDefaults().setFloat(Float(window!.frame.size.width), forKey: "screenWidth")
        return true
    }
    
    // MARK: - WatchKit request
    
    func application(application: UIApplication, handleWatchKitExtensionRequest userInfo: [NSObject : AnyObject]?, reply: (([NSObject : AnyObject]!) -> Void)!) {
        if let userInfo = userInfo {
            if let request = userInfo["request"] as? String {
                if request == "loadEntries" {
                    reply(["entriesData": NSKeyedArchiver.archivedDataWithRootObject(EntriesLoader.loadTimelineEntries())])
                    return
                } else if request == "loadMe" {
                    reply(["meData": NSKeyedArchiver.archivedDataWithRootObject(EntriesLoader.loadMe())])
                    return
                }
            }
        }
        reply([:])
    }

}
