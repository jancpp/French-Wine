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
    
    // returns a list of all regions, including duplicates
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
    
    // returns a list of all regions, excluding duplicates
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
    
    // return wines with all types (red, white, rose, sparkling) in the selected region
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
    
    // returns url string for specified region
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
        case "Loire valley":
            url = "https://en.wikipedia.org/wiki/Loire_Valley_(wine)"
        case "Provence":
            url = "https://en.wikipedia.org/wiki/Provence_wine"
        case "Rhône valley":
            url = "https://en.wikipedia.org/wiki/Rh%C3%B4ne_wine"
          
        default:
            url = "https://en.wikipedia.org/wiki/French_wine"
        }
        
        return url
    }
    
    // returns url string for specified region
    static func getImageUrl(region: Region) -> String {
        
        var url = "https://upload.wikimedia.org/wikipedia/commons/2/29/Cartes_des_vins_de_france.png"
        let regionName = region.name
        switch regionName {
        case "Alsace":
            url = "https://upload.wikimedia.org/wikipedia/commons/0/06/Weinbau-frankreich-elsass.png"
        case "Bordeaux":
            url = "https://upload.wikimedia.org/wikipedia/commons/c/cf/Weinbaugebiete-frankreich-bordeaux.png"
        case "Burgundy":
            url = "https://upload.wikimedia.org/wikipedia/commons/6/6f/Vignobles_bourgogne-fr.svg"
        case "Champagne":
            url = "https://upload.wikimedia.org/wikipedia/commons/0/02/Vignobles_champagne.svg"
        case "Languedoc-Roussillon":
            url = "https://upload.wikimedia.org/wikipedia/commons/f/f5/Vignobles_midi-fr.svg"
        case "Loire valley":
            url = "https://upload.wikimedia.org/wikipedia/commons/7/79/Vignobles_val_de_loire.png"
        case "Provence":
            url = "https://upload.wikimedia.org/wikipedia/commons/9/94/Vignobles_provence-fr.svg"
        case "Rhône valley":
            url = "https://upload.wikimedia.org/wikipedia/commons/4/4b/Vignobles_rhone.png"
            
        default:
            url = "https://upload.wikimedia.org/wikipedia/commons/2/29/Cartes_des_vins_de_france.png"
        }
        
        return url
    }
}
