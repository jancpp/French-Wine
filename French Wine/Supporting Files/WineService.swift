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
        let request: NSFetchRequest = Region.fetchRequest()
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
        let request: NSFetchRequest = Region.fetchRequest()
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
    
    static func getTypesOfRegion(type: String, moc: NSManagedObjectContext) -> NSFetchedResultsController<Region> {
        
        let fetchedResultsController: NSFetchedResultsController<Region>
        let request: NSFetchRequest = Region.fetchRequest()
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        
        request.sortDescriptors = [nameSort]
        //        request.returnsDistinctResults
        
        let predicate = NSPredicate(format: "type contains[c]", type)
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
        } catch  {
            fatalError("Error fetching data")
        }
        
        return fetchedResultsController
    }
}
