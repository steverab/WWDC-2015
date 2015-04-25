//
//  TimelineViewController.swift
//  Stephan Rabanser
//
//  Created by Stephan Rabanser on 17/04/15.
//  Copyright (c) 2015 Stephan Rabanser. All rights reserved.
//

import UIKit
import MessageUI

class TimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var timelineTableView: UITableView!
    @IBOutlet var header:UIView!
    @IBOutlet var headerLabel:UILabel!
    @IBOutlet var headerDetailLabel:UILabel!
    @IBOutlet weak var avatarView: AvatarView!
    
    @IBOutlet weak var avatarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var avatarWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var avatarLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var avatarTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var headerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    
    var headerImageView:UIImageView!
    var headerBlurImageView:UIImageView!
    var blurredHeaderImageView:UIImageView?
    
    let offsetHeaderStop:CGFloat = 65.5
    let offsetLabelHeader:CGFloat = 65.0
    let offsetAvatarHeader:CGFloat = 0.0
    let blurFadeDuration:CGFloat = 94.0
    
    let avatarWidth:CGFloat = 76.0
    
    var entries = [TimelineEntry]()
    var me = Me()
    
    var showProfile = true
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer.delegate = nil
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        /*
        avatarView.action = { [unowned self] in
            self.showProfile = !self.showProfile
            if self.showProfile == true {
                self.timelineTableView.beginUpdates()
                self.timelineTableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .Automatic)
                self.timelineTableView.endUpdates()
            } else {
                self.timelineTableView.beginUpdates()
                self.timelineTableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .Automatic)
                self.timelineTableView.endUpdates()
            }
        }
        */
        
        me = EntriesLoader.loadMe()
        
        setupStartAnimation()
        setupHeader()
        setupTableView()
        
        entries = EntriesLoader.loadTimelineEntries()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
        
        if let index = timelineTableView.indexPathForSelectedRow() {
            timelineTableView.deselectRowAtIndexPath(index, animated: true)
        }
    }
    
    // MARK: Custom functions
    
    func setupStartAnimation() {
        avatarHeightConstraint.constant = 0
        avatarWidthConstraint.constant = 0
        avatarTopConstraint.constant += avatarWidth/2
        avatarLeftConstraint.constant += avatarWidth/2
        self.avatarView.setNeedsUpdateConstraints()
        self.avatarView.layoutIfNeeded()
        
        avatarHeightConstraint.constant = avatarWidth
        avatarWidthConstraint.constant = avatarWidth
        avatarTopConstraint.constant -= avatarWidth/2
        avatarLeftConstraint.constant -= avatarWidth/2
        self.avatarView.setNeedsUpdateConstraints()
        
        timelineTableView.alpha = 0.0
        header.alpha = 0.0
        
        UIView.animateWithDuration(1.0, delay: 0.1, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: ({
            self.avatarView.layoutIfNeeded()
        }), completion: nil)
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.timelineTableView.alpha = 1.0
            self.header.alpha = 1.0
        })
    }
    
    func setupHeader() {
        let headerImg: UIImage!
        
        headerImageView = UIImageView(frame: CGRectMake(0.0, 0.0, header.frame.size.width, header.frame.size.height))
        headerImageView.contentMode = UIViewContentMode.ScaleAspectFit
        headerImageView.backgroundColor = UIColor.redColor()
        headerImageView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        header.insertSubview(headerImageView, belowSubview: headerLabel)
        
        headerBlurImageView = UIImageView(frame: headerImageView.frame)
        headerBlurImageView.contentMode = UIViewContentMode.ScaleAspectFit
        headerBlurImageView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        headerBlurImageView.alpha = 0.0
        header.insertSubview(headerBlurImageView, belowSubview: headerLabel)
        
        if view.frame.size.width >= 375.0 {
            headerImg = UIImage(named: "MiamiHeader")
            headerBlurImageView.image = headerImg?.blurredImageWithRadius(8, iterations: 20, tintColor: UIColor.clearColor())
        } else {
            headerImg = UIImage(named: "MiamiHeader5")
            headerBlurImageView.image = headerImg?.blurredImageWithRadius(8, iterations: 20, tintColor: UIColor.clearColor())
        }
        
        headerImageView.image = headerImg
        headerDetailLabel.text = me.shortDescription
        
        header.clipsToBounds = true
    }
    
    func setupTableView() {
        timelineTableView.dataSource = self
        timelineTableView.delegate = self
        
        timelineTableView.separatorStyle = .None
        
        timelineTableView.rowHeight = UITableViewAutomaticDimension
        timelineTableView.estimatedRowHeight = 44
        
        timelineTableView.contentInset = UIEdgeInsetsMake(144, 0, 0, 0)
    }
    
    // MARK: - UIScrollView delegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y + timelineTableView.contentInset.top
        var avatarTransform = CATransform3DIdentity
        var headerTransform = CATransform3DIdentity
        
        if offset < 0 {
            let headerScaleFactor:CGFloat = -(offset) / header.bounds.height
            let headerSizevariation = ((header.bounds.height * (1.0 + headerScaleFactor)) - header.bounds.height)/2.0
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            avatarTransform = CATransform3DMakeTranslation(0, -offset, 0)
            
            headerBlurImageView.alpha = -offset/150
        } else {
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offsetHeaderStop, -offset), 0)
            
            let labelTransform = CATransform3DMakeTranslation(0, max(-blurFadeDuration, offsetLabelHeader - offset), 0)
            headerLabel.layer.transform = labelTransform
            headerDetailLabel.layer.transform = labelTransform
            
            avatarTransform = CATransform3DMakeTranslation(0, max(-blurFadeDuration - 30, offsetAvatarHeader - offset), 0)
            
            headerBlurImageView.alpha = min (1.0, (offset - offsetLabelHeader)/blurFadeDuration)

            let avatarScaleFactor = (min(offsetHeaderStop, offset)) / avatarView.bounds.height / 1.25 // Slow down the animation
            let avatarSizeVariation:CGFloat = ((avatarView.bounds.height * (1.0 + avatarScaleFactor)) - avatarView.bounds.height) / 2.0
            avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation, 0)
            avatarTransform = CATransform3DScale(avatarTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0)
            
            if offset <= offsetHeaderStop {
                if avatarView.layer.zPosition < header.layer.zPosition{
                    header.layer.zPosition = 0
                }
            } else {
                if avatarView.layer.zPosition >= header.layer.zPosition{
                    header.layer.zPosition = 2
                }
            }
        }
        
        header.layer.transform = headerTransform
        avatarView.layer.transform = avatarTransform
    }
    
    // MARK: - UITableView data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showProfile == true {
            return entries.count + 1
        } else {
            return entries.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if showProfile == true {
            if indexPath.row == 0 {
                var cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell") as! ProfileCell
                configureProfileCell(cell, forIndexPath: indexPath)
                return cell
            } else {
                var cell = tableView.dequeueReusableCellWithIdentifier("TimelineEntryCell") as! TimelineEntryCell
                configureEntryCell(cell, forIndexPath: indexPath, isForOffscreenUse: false)
                return cell
            }
        } else {
            var cell = tableView.dequeueReusableCellWithIdentifier("TimelineEntryCell") as! TimelineEntryCell
            configureEntryCell(cell, forIndexPath: indexPath, isForOffscreenUse: false)
            return cell
        }
    }
    
    // MARK: Custom functions
    
    func configureProfileCell(cell: ProfileCell, forIndexPath indexPath: NSIndexPath) {
        cell.nameLabel.text = me.name
        cell.descriptionLabel.text = me.shortDescription
        cell.outlineView.type = .NoCircle
        
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
    }
    
    func configureEntryCell(cell: TimelineEntryCell, forIndexPath indexPath: NSIndexPath, isForOffscreenUse offscreenUse: Bool) {
        let currentEntry:TimelineEntry
        if showProfile == true {
            currentEntry = entries[indexPath.row-1]
        } else {
            currentEntry = entries[indexPath.row]
        }
        
        cell.titleLabel.text = currentEntry.title
        cell.shortDescriptionLabel.text = currentEntry.shortDescription
        cell.dateLabel.text = currentEntry.date
        cell.type = currentEntry.type
        
        if showProfile == true {
            if indexPath.row == 1 {
                cell.outlineView.type = .First
            } else if indexPath.row == entries.count {
                cell.outlineView.type = .Last
            } else {
                cell.outlineView.type = .Default
            }
        } else {
            if indexPath.row == 0 {
                cell.outlineView.type = .First
            } else if indexPath.row == entries.count - 1 {
                cell.outlineView.type = .Last
            } else {
                cell.outlineView.type = .Default
            }
        }
        
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
    }
    
    // MARK: - UITableView delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if showProfile == true && indexPath.row == 0 {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            setupActionSheet()
        }
    }
    
    // MARK: Custom functions
    
    func setupActionSheet() {
        let alertController = UIAlertController(title: nil, message: "Get in touch with me!", preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in }
        alertController.addAction(cancelAction)
        let emailAction = UIAlertAction(title: "E-Mail", style: .Default) { (action) in
            let mailComposerVC = MFMailComposeViewController()
            mailComposerVC.mailComposeDelegate = self
            
            mailComposerVC.setToRecipients([self.me.email])
            mailComposerVC.setSubject("Hey there!")
            mailComposerVC.setMessageBody("Hi Stephan,\n\n", isHTML: false)
            
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposerVC, animated: true, completion: nil)
            } else {
                let sendMailErrorAlert = UIAlertView(title: "Error", message: "E-Mail sending failed. Please check your E-Mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
                sendMailErrorAlert.show()
            }
        }
        alertController.addAction(emailAction)
        let twitterAction = UIAlertAction(title: "Twitter", style: .Default) { (action) in
            if !UIApplication.sharedApplication().openURL(NSURL(string:"twitter://user?screen_name=\(self.me.twitter)")!){
                if let destinationViewController = self.storyboard!.instantiateViewControllerWithIdentifier("navigationWebViewController") as? UINavigationController {
                    if let webViewController = destinationViewController.viewControllers.first as? WebViewController {
                        webViewController.url = NSURL(string:"https://twitter.com/steverab")!
                        self.navigationController?.presentViewController(destinationViewController, animated: true, completion: { () -> Void in })
                    }
                }
            }
        }
        alertController.addAction(twitterAction)
        let websiteAction = UIAlertAction(title: "Website", style: .Default) { (action) in
            if let destinationViewController = self.storyboard!.instantiateViewControllerWithIdentifier("navigationWebViewController") as? UINavigationController {
                if let webViewController = destinationViewController.viewControllers.first as? WebViewController {
                    webViewController.url = NSURL(string:"http://\(self.me.website)")!
                    self.navigationController?.presentViewController(destinationViewController, animated: true, completion: { () -> Void in })
                }
            }
        }
        alertController.addAction(websiteAction)
        
        self.presentViewController(alertController, animated: true) {}
    }
    
    // MARK: - MFMailComposeViewController delegate
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Navigation handling
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detailViewController = segue.destinationViewController as! DetailViewController
        let indexPath = timelineTableView.indexPathForSelectedRow()?.row
        
        if let indexPath = indexPath {
            if showProfile == true {
                detailViewController.timelineEntry = entries[indexPath - 1]
            } else {
                detailViewController.timelineEntry = entries[indexPath]
            }
        }
    }
    
    // MARK: - Memory management
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
