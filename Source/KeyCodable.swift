//
//  KeyCodable.swift
//  LiteData
//
//  Created by Kyle Bashour on 6/12/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

/**
 *  Conform to `KeyCodable` to provide keys for your NSManagedObject keys.
 *  It is reccomended that you use a `String` enum.
 */
public protocol KeyCodable {
    associatedtype Key: RawRepresentable
}
