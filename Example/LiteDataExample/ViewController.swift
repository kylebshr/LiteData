//
//  ViewController.swift
//  LiteData
//
//  Created by Kyle Bashour on 06/11/2016.
//  Copyright (c) 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import CoreData
import LiteData

class ViewController: UITableViewController {

    var stack: LiteStack!

    lazy var frc: NSFetchedResultsController =
        self.stack.context.sortedFetchedResults(ofType: Post.self)

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()

        frc.delegate = self

        Post.sortedFetchRequest

        do {
            try frc.performFetch()
        } catch {
            fatalError("Error performing fetch: \(error)")
        }
    }

    func setUpUI() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(insertPost))
        navigationItem.rightBarButtonItem = addButton
    }

    dynamic func insertPost() {
        let post: Post = stack.context.insert()

        post.identifier = NSUUID().UUIDString
        post.date = NSDate().timeIntervalSince1970 - 100000
        post.text = "Here's a post you inserted!"
        post.likes = random() % 30
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return frc.sections!.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return frc.sections![section].numberOfObjects
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        let post = frc.sections![indexPath.section].objects![indexPath.row] as! Post
        cell.textLabel?.text = post.text
        cell.detailTextLabel?.text = "\(post.likes) \(post.likes == 1 ? "like" : "likes")"
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("filter", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? FilterViewController {
            vc.stack = stack
            vc.post = frc.objectAtIndexPath(tableView.indexPathForSelectedRow!) as! Post
        }
    }
}

extension ViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
}
