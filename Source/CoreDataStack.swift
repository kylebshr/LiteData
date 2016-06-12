//
//  File.swift
//  LiteData
//
//  Created by Kyle Bashour on 6/11/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import CoreData

public class LiteStack {

    enum Error: ErrorType {
        case UnableToLocateModel
    }

    /// The model used to create the managed object context.
    public let model: NSManagedObjectModel

    /// The persistent store coordinator backing the managed object context.
    public let coordinator: NSPersistentStoreCoordinator

    /// The main context that should be used for most operations.
    public let context: NSManagedObjectContext

    internal static let defaultStoreLocation: NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    internal static let defaultBundle: NSBundle = {
        return NSBundle.mainBundle()
    }()

    internal static let defaultOptions: [NSObject: AnyObject] = {
        let options = [
            NSMigratePersistentStoresAutomaticallyOption: true,
            NSInferMappingModelAutomaticallyOption: true
        ]

        return options
    }()

    /**
     `LiteStack` encapsulates the setup of a core data stack,
     and provides a default managed object context for use.
     It also provides convenient defaults, and a convient method
     for creating private contexts back by the same persistent 
     coordinator.

     - parameter modelName:     The name of the model file.
     - parameter bundle:        The bundle where the `.momd` file can be found.
                                Defaults to `NSBundle.mainBundle()`.
     - parameter storeLocation: The location in which to store the database files.
                                Defaults to the documents directory.
     - paramter storeName:      The name of the file for the store. Defaults to [modelName].sqlite.
     - parameter storeType:     The type of store to initialize the persistent store with.
                                Defaults to `NSSQLiteStoreType`.
     - parameter storeOptions:  The store options for the persistent store. 
                                Defaults to `NSMigratePersistentStoresAutomaticallyOption: true`
                                and `NSInferMappingModelAutomaticallyOption: true` for 
                                automatic light weight migrations.

     - throws: If the model cannot be located or the persistent store cannot be added to the coordinator,
               we'll throw an error.

     - returns: A `CoreDataStack` initialized with the given parameters.
     */
    public init(modelName: String,
        bundle: NSBundle? = nil,
        storeLocation: NSURL? = nil,
        storeName: String? = nil,
        storeType: String = NSSQLiteStoreType,
        storeOptions: [NSObject: AnyObject]? = nil) throws {

        let storeName = storeName ?? "\(modelName).sqlite"
        let storeLocation = storeLocation ?? LiteStack.defaultStoreLocation.URLByAppendingPathComponent(storeName)
        let bundle = bundle ?? LiteStack.defaultBundle
        let storeOptions = storeOptions ?? LiteStack.defaultOptions

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

    /**
     Create a private context for doing work outside of the main context.

     - returns: A new `NSManagedObjectContext` with a private concurrency type.
     */
    public func privateContext() -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        context.persistentStoreCoordinator = coordinator
        return context
    }
}
