//
//  Subregion+CoreDataProperties.swift
//  French Wine
//
//  Created by Jan Polzer on 7/30/18.
//  Copyright © 2018 Apps KC. All rights reserved.
//
//

import Foundation
import CoreData


extension Subregion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subregion> {
        return NSFetchRequest<Subregion>(entityName: "Subregion")
    }

    @NSManaged public var name: String?
    @NSManaged public var mainRegion: Region?

}
