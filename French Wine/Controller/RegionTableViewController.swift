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
    
    private var coreData = CoreDataStack()
    
    // MARK: - Properties
    
    weak var managedObjectContext: NSManagedObjectContext! {
        didSet {
            return region = Region(context: managedObjectContext)
        }
    }
    private lazy var regions = [Region]()
    private var region: Region?

    // MARK: - Initialization

    override func viewDidLoad() {
        super.viewDidLoad()

        loadRegions()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController) -> Bool {
        if let detailVC = secondaryViewController as? DetailTableViewController {
            if detailVC.selectedRegion == nil {
                return true
            }
        }
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if regions.count > 0 {
            return regions.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "regionCell", for: indexPath) as! RegionTableViewCell
        
        cell.textLabel?.text = regions[indexPath.row].name
        
        return cell
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        
        if identifier == "Show detail" {
            
//            var tabBarController = segue.destination as UITabBarController
//            var destinationViewController = tabBarController.viewControllers[0] as YourViewController // or whatever tab index you're trying to access
//            destination.property = "some value"
            
            
            let tabBarController = segue.destination as! UITabBarController
            let destinationVC = tabBarController.viewControllers?[0] as! DetailTableViewController
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                let selectedRegion = regions[selectedIndexPath.row]
                destinationVC.selectedRegion = selectedRegion
                destinationVC.managedObjectContext = managedObjectContext
                
            }
        }
    }

    // MARK: - private
    
    private func loadRegions() {
        regions = WineService.getUniqueRegionNames(moc: coreData.persistentContainer.viewContext)
    }
}

