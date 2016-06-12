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

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        do {
            try stack.context.save()
        } catch {
            fatalError("Unable to save data: \(error)")
        }
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

