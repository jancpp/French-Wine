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
    
    static func getUrl(region: Region) -> String {
        
        var url = "https://en.wikipedia.org/wiki/French_wine"
        let regionName = region.name
        
        switch regionName {
        case "Alsace":
            url = "https://en.wikipedia.org/wiki/Alsace_wine"
        case "Bordeaux":
            url = "https://en.wikipedia.org/wiki/Bordeaux_wine"
        case "Burgundy":
            url = "https://en.wikipedia.org/wiki/Burgundy_wine"
        case "Champagne":
            url = "https://en.wikipedia.org/wiki/Champagne_(wine_region)"
        case "Languedoc-Roussillon":
            url = "https://en.wikipedia.org/wiki/Languedoc-Roussillon_wine"
        case "Loire":
            url = "https://en.wikipedia.org/wiki/Loire_Valley_(wine)"
        case "Provence":
            url = "https://en.wikipedia.org/wiki/Provence_wine"
        case "Rhone":
            url = "https://en.wikipedia.org/wiki/Rh%C3%B4ne_wine"
            
        default:
            url = "https://en.wikipedia.org/wiki/Rh%C3%B4ne_wine"
        }

        return url
    }
    
    // MARK: - Private
    
    private func encodedUrl(from string: String) -> URL? {
        // Remove preexisting encoding
        guard let decodedString = string.removingPercentEncoding,
            // Reencode, to revert decoding while encoding missed characters
            let percentEncodedString = decodedString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return nil}
        // Create URL from encoded string, or nil if failed
        return URL(string: percentEncodedString)
    }
}
