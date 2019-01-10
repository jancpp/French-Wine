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
    private var moc: NSManagedObjectContext!
    override init() {
        
        moc = coreData.persistentContainer.viewContext
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        checkData()
        connectMOCs()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        coreData.saveContext()
    }
    
    // MARK: - Private
    
    private func checkData() {
//        let moc = coreData.persistentContainer.viewContext
        let requestregions: NSFetchRequest<Region> = Region.fetchRequest()
        
        if let regionCount = try? moc.count(for: requestregions), regionCount > 0 {
            return
        }
        // run on non-main thread
        DispatchQueue.main.async {
            self.uploadSampleData()
        }
    }
    
    private func uploadSampleData() {
        
        if let url = Bundle.main.url(forResource: "wines", withExtension: "json"),
            let data = try? Data(contentsOf: url) {
            if let jsonResult = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary,
                let jsonArray = jsonResult?.value(forKey: "wines") as? NSArray {
                for json in jsonArray {
                    if let regionData = json as? [String: AnyObject] {
                        guard
                            let summary = regionData["summary"] as? String,
                            let type = regionData["type"] as? String
                            else {return}
                        
                        let region = Region(context: moc)
                        
                        region.summary = summary
                        region.type = type
                        
                        if let regionNames = regionData["region"] as? NSArray {
                            for regionName in regionNames {
                                if let nameData = regionName as? [String: AnyObject] {
                                    if let name = nameData["name"] as? String {
                                        region.name = name
                                    }
                                }
                            }
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
    private func connectMOCs() {
        let root = window?.rootViewController as? UISplitViewController
        let regionNavigation = root?.viewControllers[0] as? UINavigationController
        let regionVC = regionNavigation?.topViewController as? RegionTableViewController
        regionVC?.managedObjectContext = moc
//        let noteNavigation = regionVC?.presentedViewController as? UINavigationController
//        let noteVC = noteNavigation?.topViewController as? NotesTableViewController
//        noteVC?.managedObjectContext = moc
//        
//        let tabBar = regionVC?.tabBarController as? BaseTabBarController
        
    }
}

