//
//  Note+CoreDataProperties.swift
//  French Wine
//
//  Created by Jan Polzer on 1/6/19.
//  Copyright © 2019 Apps KC. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var body: String?

}
