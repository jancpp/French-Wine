//
//  Variety+CoreDataProperties.swift
//  French Wine
//
//  Created by Jan Polzer on 1/4/19.
//  Copyright © 2019 Apps KC. All rights reserved.
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
