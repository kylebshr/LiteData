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
import LiteData

extension Post: KeyCodable {
    enum Key: String {
        case text
        case likes
        case date
        case identifier
    }
}

extension Post: ManagedObjectType {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: Key.date.rawValue, ascending: true)]
    }
}
