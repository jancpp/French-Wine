//
//  Variety+CoreDataProperties.swift
//  French Wine
//
//  Created by Jan Polzer on 12/25/18.
//  Copyright © 2018 Apps KC. All rights reserved.
//
//

import Foundation
import CoreData


extension Variety {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Variety> {
        return NSFetchRequest<Variety>(entityName: "Variety")
    }

    @NSManaged public var name: String?
    @NSManaged public var region: Region?

}
