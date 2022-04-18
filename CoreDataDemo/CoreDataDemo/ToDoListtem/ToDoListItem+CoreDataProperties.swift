//
//  ToDoListItem+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Sajjad Malik on 18.04.22.
//
//

import Foundation
import CoreData


extension ToDoListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoListItem> {
        return NSFetchRequest<ToDoListItem>(entityName: "ToDoListItem")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var name: String?
    @NSManaged public var updatedAt: Date?

}

extension ToDoListItem : Identifiable {

}
