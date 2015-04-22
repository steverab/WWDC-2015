//
//  DetailViewController.swift
//  Stephan Rabanser
//
//  Created by Stephan Rabanser on 17/04/15.
//  Copyright (c) 2015 Stephan Rabanser. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var borderButton: BorderedButton!
    @IBOutlet weak var lineHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    var timelineEntry: TimelineEntry!
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = UIColor.colorForType(timelineEntry.type)
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        var attributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name: "AvenirNext-Medium", size: 18)!
        ]
        navigationController?.navigationBar.titleTextAttributes = attributes
        
        lineHeightConstraint.constant = 1/UIScreen.mainScreen().scale
        
        title = timelineEntry.title
        imageView.image = timelineEntry.image
        descriptionLabel.text = timelineEntry.longDescription
        shortDescriptionLabel.text = timelineEntry.shortDescription
        shortDescriptionLabel.textColor = UIColor.colorForType(timelineEntry.type)
        
        if timelineEntry.buttonTitle == "" {
            buttonHeightConstraint.constant = 0
            buttonBottomConstraint.constant = 0
            borderButton.setNeedsUpdateConstraints()
        } else {
            borderButton.borderColor = UIColor.colorForType(timelineEntry.type)
            borderButton.labelColor = UIColor.colorForType(timelineEntry.type)
            borderButton.labelText = timelineEntry.buttonTitle
            borderButton.action = {[unowned self] in
                if let destinationViewController = self.storyboard!.instantiateViewControllerWithIdentifier("navigationWebViewController") as? UINavigationController {
                    if let webViewController = destinationViewController.viewControllers.first as? WebViewController {
                        webViewController.url = self.timelineEntry.buttonURL
                        self.navigationController?.presentViewController(destinationViewController, animated: true, completion: { () -> Void in })
                    }
                }
            }
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
    }
    
    // MARK: - Custom functions
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    
    // MARK: - Memory management
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
