//
//  ViewController.swift
//  LiteData
//
//  Created by Kyle Bashour on 06/11/2016.
//  Copyright (c) 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import LiteData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var stack: CoreDataStack!

        do {
            stack = try CoreDataStack(modelName: "Model")
        } catch {
            fatalError("\(error)")
        }

        let post: Post = stack.context.insert()

        post.identifier = NSUUID().UUIDString
        post.date = NSDate().timeIntervalSince1970
        post.text = "Hello!"
        post.likes = 1000

        do {
            try stack.context.save()
        } catch {
            fatalError("\(error)")
        }


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

