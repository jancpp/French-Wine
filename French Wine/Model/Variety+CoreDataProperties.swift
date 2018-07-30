//
//  Variety+CoreDataProperties.swift
//  French Wine
//
//  Created by Jan Polzer on 7/30/18.
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
    @NSManaged public var regions: NSSet?
    @NSManaged public var wine: Wine?

}

// MARK: Generated accessors for regions
extension Variety {

    @objc(addRegionsObject:)
    @NSManaged public func addToRegions(_ value: Region)

    @objc(removeRegionsObject:)
    @NSManaged public func removeFromRegions(_ value: Region)

    @objc(addRegions:)
    @NSManaged public func addToRegions(_ values: NSSet)

    @objc(removeRegions:)
    @NSManaged public func removeFromRegions(_ values: NSSet)

}
