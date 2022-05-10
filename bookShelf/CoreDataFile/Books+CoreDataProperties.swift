//
//  Books+CoreDataProperties.swift
//  bookShelf
//
//  Created by Anak Agung Gede Agung Davin on 08/05/22.
//
//

import Foundation
import CoreData


extension Books {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Books> {
        return NSFetchRequest<Books>(entityName: "Books")
    }

    @NSManaged public var descBook: String?
    @NSManaged public var iD: Int32
    @NSManaged public var imageBook: Data?
    @NSManaged public var pageBook: String?
    @NSManaged public var statusBook: String?
    @NSManaged public var titleBook: String?

}

extension Books : Identifiable {

}
