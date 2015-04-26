//
//  DetailViewController.swift
//  Stephan Rabanser
//
//  Created by Stephan Rabanser on 17/04/15.
//  Copyright (c) 2015 Stephan Rabanser. All rights reserved.
//

import UIKit
import StoreKit

class DetailViewController: UIViewController, SKStoreProductViewControllerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var borderButton: BorderedButton!
    @IBOutlet weak var lineHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    var timelineEntry: Entry!
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupDetailView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
    }
    
    // MARK: Custom functions
    
    func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = UIColor.colorForType(timelineEntry.type)
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        var attributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name: "AvenirNext-Medium", size: 18)!
        ]
        navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    func setupDetailView() {
        lineHeightConstraint.constant = 1/UIScreen.mainScreen().scale
        
        title = timelineEntry.title
        imageView.image = timelineEntry.image
        descriptionLabel.text = timelineEntry.longDescription
        shortDescriptionLabel.text = timelineEntry.shortDescription
        shortDescriptionLabel.textColor = UIColor.colorForType(timelineEntry.type)
        
        if timelineEntry.buttonTitle == "" || (UIDevice.currentDevice().model == "iPhone Simulator" && timelineEntry.title == "Piqup") {
            buttonHeightConstraint.constant = 0
            buttonBottomConstraint.constant = 0
            borderButton.setNeedsUpdateConstraints()
        } else {
            borderButton.borderColor = UIColor.colorForType(timelineEntry.type)
            borderButton.labelColor = UIColor.colorForType(timelineEntry.type)
            borderButton.labelText = timelineEntry.buttonTitle
            borderButton.action = {[unowned self] in
                if self.timelineEntry.title != "Piqup App" {
                    if let destinationViewController = self.storyboard!.instantiateViewControllerWithIdentifier("navigationWebViewController") as? UINavigationController {
                        if let webViewController = destinationViewController.viewControllers.first as? WebViewController {
                            webViewController.url = self.timelineEntry.buttonURL
                            self.navigationController?.presentViewController(destinationViewController, animated: true, completion: { () -> Void in })
                        }
                    }
                } else {
                    let storeViewController = SKStoreProductViewController()
                    storeViewController.delegate = self
                    
                    let parameters = [SKStoreProductParameterITunesItemIdentifier :
                        NSNumber(integer: 718548316)]
                    
                    storeViewController.loadProductWithParameters(parameters,
                        completionBlock: {result, error in
                            if result {
                                self.presentViewController(storeViewController,
                                    animated: true, completion: nil)
                            }
                            
                    })
                }
            }
        }
    }
    
    // MARK: - SKStoreProductViewController delegate
    
    func productViewControllerDidFinish(viewController:
        SKStoreProductViewController!) {
            viewController.dismissViewControllerAnimated(true,
                completion: nil)
    }
    
    // MARK: - Memory management
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
