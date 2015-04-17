//
//  DetailViewController.swift
//  Stephan Rabanser
//
//  Created by Stephan Rabanser on 17/04/15.
//  Copyright (c) 2015 Stephan Rabanser. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var timelineEntry: TimelineEntry!
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = UIColor.colorForType(timelineEntry.type)
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    // MARK: - Functions
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    // MARK: - Memory management
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
