//
//  Post.swift
//  
//
//  Created by Kyle Bashour on 6/11/16.
//
//

import Foundation
import CoreData
import LiteData


class Post: NSManagedObject {

    @NSManaged var text: String
    @NSManaged var likes: Int
    @NSManaged var date: NSTimeInterval
    @NSManaged var identifier: String

}
