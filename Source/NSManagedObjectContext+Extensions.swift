//
//  NSManagedObjectContext+Extensions.swift
//  LiteData
//
//  Created by Kyle Bashour on 6/12/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {

    /**
     Create and insert an NSManagedObject into context `self`. 
     The type must conform to `EntityType`.
     
     Example: 
     
     ```
     let user: User = moc.insert()
     ```

     - returns: The NSManagedObject created within the context.
     */
    public func insert<ObjectType: NSManagedObject where ObjectType: EntityType>() -> ObjectType {

        guard let object = NSEntityDescription
            .insertNewObjectForEntityForName(ObjectType.entityName, inManagedObjectContext: self) as? ObjectType else {
            fatalError("Unable to create class \(ObjectType.self) from entityName \(ObjectType.entityName)")
        }

        return object
    }

    /**
     Create an NSFetchedResultsController for the given type. 
     The type must conform to `ManagedObjectType`. The results
     are sorted by `defaultSortDescriptors` and the `sectionNameKeyPath`
     is set based on the first sort descriptor.

     - parameter type:      The class for which the fetched results controller is created.
     - parameter cacheName: The name of the cache file the receiver should use. Pass nil to prevent caching.

     - returns: The NSFetchedResultsController initialized with the given type, cache, and the default sort descriptors.
     */
    public func sortedFetchedResults<ObjectType: NSManagedObject where ObjectType: ManagedObjectType>(
        ofType type: ObjectType.Type,
        cacheName: String? = nil) -> NSFetchedResultsController {

        return NSFetchedResultsController(
            fetchRequest: type.sortedFetchRequest,
            managedObjectContext: self,
            sectionNameKeyPath: type.defaultSortDescriptors.first?.key,
            cacheName: cacheName
        )
    }
}
