//
//  Region+Extension.swift
//  French Wine
//
//  Created by Jan Polzer on 8/14/18.
//  Copyright © 2018 Apps KC. All rights reserved.
//

import Foundation
import CoreData

extension Region {
    func getRegionsByType(type: String, moc: NSManagedObjectContext) -> [Region] {
        let request: NSFetchRequest<Region> = Region.fetchRequest()
        //        request.predicate = NSPredicate(format: "type = %@", NSString(string: type))
        request.predicate = NSPredicate(format: "type = %@", NSString(string: type))
        
        do {
            let regions = try moc.fetch(request)
            return regions
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    // MARK: - Private
    
//    private func loadData() {
//        if let regions = region?.getRe
//    }
}
