//
//  KeyCodable.swift
//  LiteData
//
//  Created by Kyle Bashour on 6/12/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation

public protocol KeyCodable {
    associatedtype Key: RawRepresentable
}
