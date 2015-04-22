//
//  WebViewController.swift
//  Stephan Rabanser
//
//  Created by Stephan Rabanser on 23/04/15.
//  Copyright (c) 2015 Stephan Rabanser. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    var url: NSURL!
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
        webView.loadRequest(NSURLRequest(URL: url))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Actions
    
    @IBAction func dismiss(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: { () -> Void in })
    }
    
    // MARK: - Custom functions
    
    // MARK: - Memory management
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
