//
//  File.swift
//  LiteData
//
//  Created by Kyle Bashour on 6/11/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import CoreData

public class CoreDataStack {

    enum Error: ErrorType {
        case UnableToLocateModel
    }

    public let model: NSManagedObjectModel
    public let coordinator: NSPersistentStoreCoordinator
    public let context: NSManagedObjectContext

    private static let defaultStoreLocation: NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    private static let defaultBundle: NSBundle = {
        return NSBundle.mainBundle()
    }()

    private static let defaultOptions: [NSObject: AnyObject] = {
        let options = [
            NSMigratePersistentStoresAutomaticallyOption: true,
            NSInferMappingModelAutomaticallyOption: true
        ]

        return options
    }()

    public init(modelName: String,
        storeLocation: NSURL? = nil,
        bundle: NSBundle? = nil,
        storeType: String = NSSQLiteStoreType,
        storeOptions: [NSObject: AnyObject]? = nil) throws {

        let storeLocation = storeLocation ?? CoreDataStack.defaultStoreLocation.URLByAppendingPathComponent("\(modelName).sqlite")
        let bundle = bundle ?? CoreDataStack.defaultBundle
        let storeOptions = storeOptions ?? CoreDataStack.defaultOptions

        guard let modelURL = bundle.URLForResource(modelName, withExtension: "momd"),
            model = NSManagedObjectModel(contentsOfURL: modelURL) else {
            throw Error.UnableToLocateModel
        }

        coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)

        do {
            try coordinator.addPersistentStoreWithType(storeType, configuration: nil, URL: storeLocation, options: storeOptions)
        } catch {
            throw error
        }

        self.model = model
        self.context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)

        context.persistentStoreCoordinator = coordinator
    }

    func save() throws {

    }
}
