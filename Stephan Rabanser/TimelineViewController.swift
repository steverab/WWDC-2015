//
//  TimelineViewController.swift
//  Stephan Rabanser
//
//  Created by Stephan Rabanser on 17/04/15.
//  Copyright (c) 2015 Stephan Rabanser. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var timelineTableView: UITableView!
    @IBOutlet var header:UIView!
    @IBOutlet var headerLabel:UILabel!
    
    var headerImageView:UIImageView!
    var headerBlurImageView:UIImageView!
    var blurredHeaderImageView:UIImageView?
    
    let offsetHeaderStop:CGFloat = 60.0
    let offsetLabelHeader:CGFloat = 65.0
    let blurFadeDuration:CGFloat = 35.0
    
    var entries = [TimelineEntry]()
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer.delegate = nil
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        setupHeader()
        setupTableView()
        loadEntries()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    // MARK: - Functions
    
    func setupHeader() {
        headerImageView = UIImageView(frame: header.frame)
        headerImageView?.image = UIImage(named: "Singapore")
        headerImageView?.contentMode = UIViewContentMode.ScaleAspectFill
        header.insertSubview(headerImageView, belowSubview: headerLabel)
        
        headerBlurImageView = UIImageView(frame: header.frame)
        headerBlurImageView?.image = UIImage(named: "Singapore")?.blurredImageWithRadius(10, iterations: 20, tintColor: UIColor.clearColor())
        headerBlurImageView?.contentMode = UIViewContentMode.ScaleAspectFill
        headerBlurImageView?.alpha = 0.0
        header.insertSubview(headerBlurImageView, belowSubview: headerLabel)
        
        header.clipsToBounds = true
    }
    
    func setupTableView() {
        timelineTableView.dataSource = self
        timelineTableView.delegate = self
        
        timelineTableView.separatorStyle = .None
        
        timelineTableView.rowHeight = UITableViewAutomaticDimension
        timelineTableView.estimatedRowHeight = 44
        
        timelineTableView.contentInset = UIEdgeInsetsMake(105, 0, 0, 0)
    }
    
    func loadEntries() {
        let loadedEntries = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("Entries", ofType: "plist")!)
        for dict in loadedEntries ?? [] {
            let entry = TimelineEntry(title: dict["title"] as! String, shortDescription: dict["shortDescription"] as! String, description: dict["description"] as! String, date: dict["date"] as! String, type: TimelineEntryType(rawValue: dict["type"] as! Int)!, imageString: dict["image"] as! String)
            entries.append(entry)
        }
    }
    
    // MARL: - Scroll view delegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y + timelineTableView.contentInset.top
        var avatarTransform = CATransform3DIdentity
        var headerTransform = CATransform3DIdentity
        
        if offset < 0 {
            let headerScaleFactor:CGFloat = -(offset) / header.bounds.height
            let headerSizevariation = ((header.bounds.height * (1.0 + headerScaleFactor)) - header.bounds.height)/2.0
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
        } else {
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offsetHeaderStop, -offset), 0)
            
            let labelTransform = CATransform3DMakeTranslation(0, max(-blurFadeDuration, offsetLabelHeader - offset), 0)
            headerLabel.layer.transform = labelTransform
            
            headerBlurImageView?.alpha = min (1.0, (offset - offsetLabelHeader)/blurFadeDuration)
        }
        
        header.layer.transform = headerTransform
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TimelineEntryCell") as! TimelineEntryCell
        configureCell(cell, forIndexPath: indexPath, isForOffscreenUse: false)
        return cell
    }
    
    func configureCell(cell: TimelineEntryCell, forIndexPath indexPath: NSIndexPath, isForOffscreenUse offscreenUse: Bool) {
        let currentEntry = entries[indexPath.row]
        
        cell.titleLabel.text = currentEntry.title
        cell.shortDescriptionLabel.text = currentEntry.shortDescription
        cell.dateLabel.text = currentEntry.date
        cell.type = currentEntry.type
        
        if indexPath.row == entries.count - 1 {
            cell.outlineView.type = .Last
        } else {
            cell.outlineView.type = .Default
        }
        
        cell.outlineView.setNeedsDisplay()
        
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
    }
    
    // MARK: - Table view delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detailViewController = segue.destinationViewController as! DetailViewController
        
        let indexPath = timelineTableView.indexPathForSelectedRow()?.row
        
        if let indexPath = indexPath {
            detailViewController.timelineEntry = entries[indexPath]
        }
        
    }
    
    // MARK: - Memory management
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
