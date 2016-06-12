//
//  AppDelegate.swift
//  LiteData
//
//  Created by Kyle Bashour on 06/11/2016.
//  Copyright (c) 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import LiteData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    lazy var stack: CoreDataStack = {
        do {
            return try CoreDataStack(modelName: "Model")
        } catch {
            fatalError("Unable to create core data stack: \(error)")
        }
    }()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        setUpInitialData()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootViewController = storyboard.instantiateInitialViewController() as! ViewController

        rootViewController.stack = stack

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        window?.makeKeyAndVisible()

        return true
    }

    func setUpInitialData() {

        let objects = stack.context.sortedFetchedResults(ofType: Post.self).fetchedObjects

        guard objects == nil || objects?.count == 0 else {
            return
        }

        for i in 0...200 {
            let post: Post = stack.context.insert()
            post.identifier = NSUUID().UUIDString
            post.date = NSDate().timeIntervalSince1970
            post.text = "This is post number \(i) 🎉"
            post.likes = random() % 100
        }
    }

    func applicationDidEnterBackground(application: UIApplication) {
        do {
            try stack.context.save()
        } catch {
            fatalError("Unable to save data: \(error)")
        }
    }
}
