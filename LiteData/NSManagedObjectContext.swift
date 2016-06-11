//
//  NSManagedObjectModel.swift
//  Pods
//
//  Created by Kyle Bashour on 6/11/16.
//
//

import CoreData

extension NSManagedObjectContext {

    public func insert<ObjectType: NSManagedObject where ObjectType: EntityType>() -> ObjectType {
        guard let object = NSEntityDescription
            .insertNewObjectForEntityForName(ObjectType.entityName, inManagedObjectContext: self) as? ObjectType else {
            fatalError("Unable to create class \(ObjectType.self) from entityName \(ObjectType.entityName)")
        }

        return object
    }
}
