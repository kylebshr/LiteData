//
//  ManagedObjectType.swift
//  Pods
//
//  Created by Kyle Bashour on 6/12/16.
//
//

import CoreData

public protocol ManagedObjectType: EntityType {

    /// This property will be used for `sortedFetchRequest` and `sortedFetchedResults`.
    ///
    /// The first descriptor in the array will be used for the `sectionNameKeyPath`
    /// of `sortedFetchedResults`.
    static var defaultSortDescriptors: [NSSortDescriptor] { get }
}

extension ManagedObjectType {

    /// A fetch request created using `defaultSortDescriptors`.
    public static var sortedFetchRequest: NSFetchRequest {
        let request = NSFetchRequest(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        return request
    }
}
