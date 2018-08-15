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

    static func getRegions(moc: NSManagedObjectContext) -> NSFetchedResultsController<Region> {
        let fetchedResultsController: NSFetchedResultsController<Region>
        let request: NSFetchRequest = Region.fetchRequest()
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [nameSort]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
        } catch  {
            fatalError("Error fetching data")
        }
        
        return fetchedResultsController
    }
    
}
