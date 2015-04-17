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
    
    var entries = [TimelineEntry]()
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer.delegate = nil
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        setupTableView()
        loadEntries()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }
    
    // MARK: - Functions
    
    func setupTableView() {
        timelineTableView.dataSource = self
        timelineTableView.delegate = self
        
        timelineTableView.separatorStyle = .None
        
        timelineTableView.rowHeight = UITableViewAutomaticDimension
        timelineTableView.estimatedRowHeight = 44
    }
    
    func loadEntries() {
        let loadedEntries = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("Entries", ofType: "plist")!)
        for dict in loadedEntries ?? [] {
            let entry = TimelineEntry(title: dict["title"] as! String, shortDescription: dict["shortDescription"] as! String, date: dict["date"] as! String, type: TimelineEntryType(rawValue: dict["type"] as! Int)!)
            entries.append(entry)
        }
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
