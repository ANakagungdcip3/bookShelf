//
//  BooksCore.swift
//  bookShelf
//
//  Created by Anak Agung Gede Agung Davin on 30/04/22.
//

import Foundation
import CoreData

@objc(Books)
class Books: NSManagedObject{
    @NSManaged var iD: NSNumber!
    @NSManaged var descBook: NSString!
    @NSManaged var imageBook: NSData!
    @NSManaged var pageBook: NSNumber!
    @NSManaged var statusBook: NSDate?
    @NSManaged var titleBook: NSString!
}

