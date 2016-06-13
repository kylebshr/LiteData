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

        let things: [Post] = stack.context.all(where: Post.Key.likes, matches: 300)
        print(things)
        print(stack.context.all() as [Post])
    }

    func setUpUI() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(insertPost))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.title = "LiteData Example"
    }

    dynamic func insertPost() {
        let post: Post = stack.context.insert()

        post.identifier = NSUUID().UUIDString
        post.date = NSDate().timeIntervalSince1970 - 100000
        post.text = "Here's a post you inserted!"
        post.likes = random() % 100
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
        cell.detailTextLabel?.text = "\(post.likes)"
        return cell
    }
}

extension ViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
}
