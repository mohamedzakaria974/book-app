//
//  BookCoreData+CoreDataProperties.swift
//  BookCase
//
//  Created by Mohamed Zakaria on 5/9/18.
//  Copyright © 2018 Mohamed Zakaria. All rights reserved.
//

import Foundation
import CoreData
import UIKit


extension BookCoreData {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookCoreData> {
        return NSFetchRequest<BookCoreData>(entityName: "Book");
    }
    
    @NSManaged public var title: String
    @NSManaged public var titleIndex: String
    @NSManaged public var subtitle: String?
    @NSManaged public var authors: String
    @NSManaged public var publisher: String?
    @NSManaged public var publishedDateAttr: Date?
    @NSManaged public var publishedDateTypeAttr: String?
    @NSManaged public var pagesAttr: Int16
    @NSManaged public var googleBookURL: String?
    @NSManaged public var language: String?
    @NSManaged public var isbn: String?
    @NSManaged public var coverURL: String?
    @NSManaged public var coverImage: UIImage?
    
}
