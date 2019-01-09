//
//  RegionTableViewController.swift
//  French Wine
//
//  Created by Jan Polzer on 7/30/18.
//  Copyright © 2018 Apps KC. All rights reserved.
//

import UIKit
import CoreData

class RegionTableViewController: UITableViewController, UISplitViewControllerDelegate {
    
    // MARK: - Properties
    
    private var coreData = CoreDataStack()
    private lazy var regionsList = [Region]()
    private var selectedRegion: Region?
    private var wineService: WineService?
    
    var managedObjectContext: NSManagedObjectContext? {
        didSet {
            if let moc = managedObjectContext {
                wineService = WineService(moc: moc)
            }
        }
    }
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "French wine"
        loadRegions()
        
    }
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if regionsList.count > 0 {
            return regionsList.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "regionCell", for: indexPath) as! RegionTableViewCell
        cell.textLabel?.text = regionsList[indexPath.row].name
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        
        if identifier == "Show detail" {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                selectedRegion = regionsList[selectedIndexPath.row]
                
                let tabBarController = segue.destination as? BaseTabBarController
                tabBarController?.selectedRegion = selectedRegion
                
                // link DetailTableViewController
                let navigationController = tabBarController?.viewControllers?[0] as? UINavigationController
                let detailVC = navigationController?.topViewController as? DetailTableViewController
                detailVC?.managedObjectContext = managedObjectContext
                detailVC?.selectedRegion = selectedRegion
                
                // link WikiViewController
                let wikiVC = tabBarController?.viewControllers?[1] as? WikiViewController
                wikiVC?.managedObjectContext = managedObjectContext
                wikiVC?.selectedRegion = selectedRegion
                
                // link MapViewController
                let mapVC = tabBarController?.viewControllers?[2] as? MapViewController
                mapVC?.managedObjectContext = managedObjectContext
                mapVC?.selectedRegion = selectedRegion
            }
        } else if identifier == "Show notes" {
            let navigationController = segue.destination as? UINavigationController
            let notesVC = navigationController?.topViewController as? NotesTableViewController
            notesVC?.managedObjectContext = managedObjectContext
        }
    }
    
    // MARK: - private
    
    private func loadRegions() {
        if let regions = wineService?.getUniqueRegionNames() {
            regionsList = regions
            tableView.reloadData()
        }
    }
}

extension UIViewController {
        var contents: UIViewController {
            if let navcon = self as? UINavigationController {
                return navcon.visibleViewController ?? self
            } else {
                return self
            }
        }
}
