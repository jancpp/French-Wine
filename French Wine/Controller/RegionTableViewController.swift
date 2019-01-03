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
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
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
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                let selectedRegion = regions[selectedIndexPath.row]
                
                let navigationController: UINavigationController! = segue.destination as? UINavigationController
                
                let tabBarController: BaseTabBarController! = navigationController.topViewController as? BaseTabBarController
                tabBarController.selectedRegion = selectedRegion

                let detailVC: DetailTableViewController! = tabBarController.viewControllers?[0] as? DetailTableViewController
                detailVC.selectedRegion = selectedRegion
                detailVC.title = selectedRegion.name
            }
        }
    }
    
    // MARK: - private
    
    private func loadRegions() {
        regions = WineService.getUniqueRegionNames(moc: coreData.persistentContainer.viewContext)
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
