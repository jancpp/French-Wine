//
//  Region+CoreDataProperties.swift
//  French Wine
//
//  Created by Jan Polzer on 7/30/18.
//  Copyright © 2018 Apps KC. All rights reserved.
//
//

import Foundation
import CoreData


extension Region {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Region> {
        return NSFetchRequest<Region>(entityName: "Region")
    }

    @NSManaged public var name: String?
    @NSManaged public var picture: NSObject?
    @NSManaged public var subRegions: NSSet?
    @NSManaged public var varieties: NSSet?
    @NSManaged public var wine: Wine?

}

// MARK: Generated accessors for subRegions
extension Region {

    @objc(addSubRegionsObject:)
    @NSManaged public func addToSubRegions(_ value: Subregion)

    @objc(removeSubRegionsObject:)
    @NSManaged public func removeFromSubRegions(_ value: Subregion)

    @objc(addSubRegions:)
    @NSManaged public func addToSubRegions(_ values: NSSet)

    @objc(removeSubRegions:)
    @NSManaged public func removeFromSubRegions(_ values: NSSet)

}

// MARK: Generated accessors for varieties
extension Region {

    @objc(addVarietiesObject:)
    @NSManaged public func addToVarieties(_ value: Variety)

    @objc(removeVarietiesObject:)
    @NSManaged public func removeFromVarieties(_ value: Variety)

    @objc(addVarieties:)
    @NSManaged public func addToVarieties(_ values: NSSet)

    @objc(removeVarieties:)
    @NSManaged public func removeFromVarieties(_ values: NSSet)

}
