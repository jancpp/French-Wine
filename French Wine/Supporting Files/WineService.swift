//
//  WineService.swift
//  French Wine
//
//  Created by Jan Polzer on 8/7/18.
//  Copyright © 2018 Apps KC. All rights reserved.
//

import Foundation
import CoreData

class WineService {
    static func getAllRegions(moc: NSManagedObjectContext) -> [Region] {
        
        var regions = [Region]()
        let request: NSFetchRequest<Region> = Region.fetchRequest()
        
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [nameSort]
        
        do {
            regions = try moc.fetch(request)
        } catch  {
            fatalError("Error fetching data")
        }
        
        return regions
    }
    
    static func getUniqueRegionNames(moc: NSManagedObjectContext) -> [Region] {
        
        var regions = [Region]()
        var uniqueRegions = [Region]()
        var uniqueRegionNames = [String]()
        let request: NSFetchRequest<Region> = Region.fetchRequest()
        
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [nameSort]
        
        do {
            regions = try moc.fetch(request)
        } catch  {
            fatalError("Error fetching data")
        }
        
        for region in regions {
            if !uniqueRegionNames.contains(region.name!) {
                uniqueRegionNames.append(region.name!)
                uniqueRegions.append(region)
            }
        }

        return uniqueRegions
    }
    
    // Return wines with all types (red, white, rose, sparkling) in the selected region
    static func getTypesOfRegion(moc: NSManagedObjectContext, region: Region) -> [Region] {
        
        var regions = [Region]()
        let request: NSFetchRequest<Region> = Region.fetchRequest()
//        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        let predicate = NSPredicate(format: "name = %@", region.name!)
        
//        request.sortDescriptors = [nameSort]
        request.predicate = predicate
        
        do {
            regions = try moc.fetch(request)
        } catch  {
            fatalError("Error fetching data")
        }
        
        return regions
    }
}
