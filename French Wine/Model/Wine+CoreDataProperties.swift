//
//  Wine+CoreDataProperties.swift
//  French Wine
//
//  Created by Jan Polzer on 7/30/18.
//  Copyright © 2018 Apps KC. All rights reserved.
//
//

import Foundation
import CoreData


extension Wine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Wine> {
        return NSFetchRequest<Wine>(entityName: "Wine")
    }

    @NSManaged public var type: String?
    @NSManaged public var summary: String?
    @NSManaged public var region: Region?
    @NSManaged public var varierites: NSSet?

}

// MARK: Generated accessors for varierites
extension Wine {

    @objc(addVarieritesObject:)
    @NSManaged public func addToVarierites(_ value: Variety)

    @objc(removeVarieritesObject:)
    @NSManaged public func removeFromVarierites(_ value: Variety)

    @objc(addVarierites:)
    @NSManaged public func addToVarierites(_ values: NSSet)

    @objc(removeVarierites:)
    @NSManaged public func removeFromVarierites(_ values: NSSet)

}
