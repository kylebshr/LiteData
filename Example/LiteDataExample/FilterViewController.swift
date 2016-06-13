//
//  FilterViewController.swift
//  LiteDataExample
//
//  Created by Kyle Bashour on 6/12/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import CoreData
import LiteData

class FilterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var postLabel: UILabel!


    var post: Post!
    var stack: LiteStack!

    lazy var similarPosts: [Post] = {
        let predicate = NSPredicate(
            format: "\(Post.Key.likes.rawValue) == \(self.post.likes) AND SELF != %@", self.post
        )
        return self.stack.context.all(predicate: predicate)
    }()

    override func viewDidLoad() {
        setUpUI()
    }

    func setUpUI() {
        postLabel.text = post.text
        tableView.dataSource = self
        tableView.reloadData()
    }
}

extension FilterViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return similarPosts.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        let post = similarPosts[indexPath.row]

        cell.textLabel?.text = post.text
        cell.detailTextLabel?.text = "\(post.likes) \(post.likes == 1 ? "like" : "likes")"

        return cell
    }
}
