//
//  Post+CoreDataProperties.swift
//  
//
//  Created by Kyle Bashour on 6/11/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Post {

    @NSManaged var text: String
    @NSManaged var likes: Int64
    @NSManaged var date: NSTimeInterval
    @NSManaged var identifier: String

}
