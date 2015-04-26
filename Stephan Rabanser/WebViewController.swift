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
    
    var refreshButton: UIBarButtonItem!
    var stopButton: UIBarButtonItem!
    var refreshStopButton: UIBarButtonItem!
    var nextButton: UIBarButtonItem!
    var previousButton: UIBarButtonItem!
    var actionsButton: UIBarButtonItem!
    var space: UIBarButtonItem!
    
    var url: NSURL!
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = ""

        setupNavigationBar()
        setupWebView()
        setupToolbar()
        updateToolbar()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        tearDownWebView()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    // MARK: Custom functions
    
    func setupNavigationBar() {
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
        navigationController?.setToolbarHidden(false, animated: true)
    }
    
    func setupWebView() {
        webView.loadRequest(NSURLRequest(URL: url))
        webView.delegate = self
        webView.opaque = false
    }
    
    func setupToolbar() {
        refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: webView, action: "reload")
        stopButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Stop, target: webView, action: "stopLoading")
        nextButton = UIBarButtonItem(image: UIImage(named: "ArrowRight"), style: .Plain, target: webView, action: "goForward")
        previousButton = UIBarButtonItem(image: UIImage(named: "ArrowLeft"), style: .Plain, target: webView, action: "goBack")
        actionsButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "presentActivities")
        
        space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        refreshStopButton = refreshButton
    }
    
    func updateToolbar() {
        nextButton.enabled = webView.canGoForward
        previousButton.enabled = webView.canGoBack
        
        setToolbarItems([previousButton, space, nextButton, space, refreshStopButton, space, actionsButton], animated: false)
    }
    
    func presentActivities() {
        let shareObjects = [title!, url] as [AnyObject]
        let act = [SafariActivity(url: url)] as [AnyObject]
        let avc = UIActivityViewController(activityItems: shareObjects, applicationActivities: act)
        navigationController?.presentViewController(avc, animated: true, completion: nil)
    }
    
    func presentActions() {
        let alertController = UIAlertController(title: nil, message: url.absoluteString, preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in }
        alertController.addAction(cancelAction)
        let emailAction = UIAlertAction(title: "Open in Safari", style: .Default) { (action) in
            UIApplication.sharedApplication().openURL(url)
        }
        alertController.addAction(emailAction)
        let twitterAction = UIAlertAction(title: "Copy to clipboard", style: .Default) { (action) in
            UIPasteboard.generalPasteboard().URL = self.url
        }
        alertController.addAction(twitterAction)
        
        self.presentViewController(alertController, animated: true) {}
    }
    
    func tearDownWebView() {
        webView.stopLoading()
        webView.delegate = nil
    }
    
    // MARK: - UIWebView delegate
    
    func webViewDidStartLoad(webView: UIWebView) {
        refreshStopButton = stopButton
        updateToolbar()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        title = webView.stringByEvaluatingJavaScriptFromString("document.title")
        url = webView.request!.URL
        refreshStopButton = refreshButton
        updateToolbar()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        refreshStopButton = refreshButton
        updateToolbar()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    // MARK: - Actions
    
    @IBAction func dismiss(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: { () -> Void in })
    }
    
    // MARK: - Memory management
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
