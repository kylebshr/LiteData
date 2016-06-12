//
//  ManagedObjectType+Extensions.swift
//  LiteData
//
//  Created by Kyle Bashour on 6/12/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import CoreData

extension ManagedObjectType {

    /// A fetch request created using `defaultSortDescriptors`.
    public static var sortedFetchRequest: NSFetchRequest {
        let request = NSFetchRequest(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        return request
    }
}
