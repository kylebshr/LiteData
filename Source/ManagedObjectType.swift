//
//  ManagedObjectType.swift
//  LiteData
//
//  Created by Kyle Bashour on 6/12/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import CoreData

/**
 *  Conform to `ManagedObjectType` to expose your object to LiteData methods.
 */
public protocol ManagedObjectType: EntityType {

    /// This property will be used for `sortedFetchRequest` and `sortedFetchedResults`.
    ///
    /// The first descriptor in the array will be used for the `sectionNameKeyPath`
    /// of `sortedFetchedResults`.
    static var defaultSortDescriptors: [NSSortDescriptor] { get }
}
