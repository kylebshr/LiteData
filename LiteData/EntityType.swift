//
//  Entity.swift
//  Pods
//
//  Created by Kyle Bashour on 6/11/16.
//
//

public protocol EntityType {

    /// The name of the entity in the data model. 
    /// Defaults to the class name of `self`.
    static var entityName: String { get }
}

public extension EntityType {
    static var entityName: String {
        return String(self)
    }
}
