//
//  EntityType.swift
//  LiteData
//
//  Created by Kyle Bashour on 6/12/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

public protocol EntityType {

    /// The name of the entity in the data model. 
    /// Defaults to the class name of `self`.
    static var entityName: String { get }
}

