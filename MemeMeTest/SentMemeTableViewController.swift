//
//  SentMemeTableViewController.swift
//  MemeMeTest
//
//  Created by Caroline Davis on 11/08/2016.
//  Copyright © 2016 Caroline Davis. All rights reserved.
//

import UIKit

class SentMemeTableViewController: UITableViewController {
    
    var tableCell = "memeCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The tableview cell class and its reuse identifier name
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: tableCell)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        }
    
    // The array of saved meme data coming from AppDelegate
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    // First essential func - number of rows in tableview
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    // Second essential func - create a cell for each tableview row
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // reuses a cell or creates a new one
        let cell = tableView.dequeueReusableCellWithIdentifier(self.tableCell)!
        let meme = self.memes[indexPath.row]
        
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = meme.topText + "..." + meme.bottomText
        
        return cell
    }
    
    // Third essential func - what happens when tableview cell is tapped
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
    
        detailController.meme = self.memes[indexPath.row]
        
        // Present the view controller using navigation
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
}
