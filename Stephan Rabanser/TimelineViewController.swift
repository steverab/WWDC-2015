//
//  TimelineViewController.swift
//  Stephan Rabanser
//
//  Created by Stephan Rabanser on 17/04/15.
//  Copyright (c) 2015 Stephan Rabanser. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    
    @IBOutlet weak var timelineTableView: UITableView!
    
    var entries = [TimelineEntry]()
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadEntries()
    }
    
    // MARK: - Functions
    
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
        var cell = tableView.dequeueReusableCellWithIdentifier("EntryTableViewCell") as! UITableViewCell
        return cell
    }
    
    // MARK: - Table view delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - Memory management
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
