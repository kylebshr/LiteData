//
//  NSManagedObject+EntityType.swift
//  Pods
//
//  Created by Kyle Bashour on 6/11/16.
//
//

import CoreData

extension NSManagedObject: EntityType {
    public static var entityName: String {
        return String(self)
    }
}
