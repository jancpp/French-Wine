//
//  AppDelegate.swift
//  French region
//
//  Created by Jan Polzer on 7/30/18.
//  Copyright © 2018 Apps KC. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var coreData = CoreDataStack()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        checkData()
        
//        let managedObjectContext = coreData.persistentContainer.viewContext
        
//        let rootTableViewController = managedObjectContext.t
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        coreData.saveContext()
    }
    
    // MARK: - Private
    
    private func checkData() {
        let moc = coreData.persistentContainer.viewContext
        let requestregions: NSFetchRequest<Region> = Region.fetchRequest()
        
        if let regionCount = try? moc.count(for: requestregions), regionCount > 0 {
            return
        }
        
        uploadSampleData()
    }
    
    private func uploadSampleData() {
        let moc = coreData.persistentContainer.viewContext
        
        if let url = Bundle.main.url(forResource: "wines", withExtension: "json"),
            let data = try? Data(contentsOf: url) {
            if let jsonResult = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary,
                let jsonArray = jsonResult?.value(forKey: "wines") as? NSArray {
                for json in jsonArray {
                    if let regionData = json as? [String: AnyObject] {
                        guard
//                            let wineRegion = regionData["region"],
                            let summary = regionData["summary"] as? String,
                            let type = regionData["type"] as? String
                            else {return}
                        
                        let region = Region(context: moc)
                        
                        region.summary = summary
                        region.type = type
                        
                        if let regionNames = regionData["region"] as? NSArray {
//                        let regionNamesData = region.varieties?.mutableCopy() as! NSMutableSet
                        
                        for regionName in regionNames {
                            if let nameData = regionName as? [String: AnyObject] {
                                if let name = nameData["name"] as? String {
                                    region.name = name
                                }
                            }
                        }
//                            region.addToVarieties(regionNamesData.copy() as! NSSet)
                    }
                    
                      
                        if let regionVarieties = regionData["varieties"] as? NSArray {
                            let regionVarietyData = region.varieties?.mutableCopy() as! NSMutableSet
                            
                            for regionVariety in regionVarieties {
                                if let varietyData = regionVariety as? [String: AnyObject] {
                                    
                                    let variety = Variety(context: moc)
                                    
                                    if let name = varietyData["name"] as? String {
                                        variety.name = name
                                    }
                                    regionVarietyData.add(variety)
                                }
                            }
                            region.addToVarieties(regionVarietyData.copy() as! NSSet)
                        }
                    }
                }
                coreData.saveContext()
            }
        }
    }
}

