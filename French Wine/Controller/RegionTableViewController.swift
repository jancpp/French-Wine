//
//  RootTableViewController.swift
//  French Wine
//
//  Created by Jan Polzer on 7/30/18.
//  Copyright © 2018 Apps KC. All rights reserved.
//

import UIKit
import CoreData


class RegionTableViewController: UITableViewController {
    
    private var coreData = CoreDataStack()
    private var fetchResultController: NSFetchedResultsController<Region>?
    
    // MARK: - Properties
    
//    weak var managedObjectContext: NSManagedObjectContext! {
//        didSet {
//            return region = Region(context: managedObjectContext)
//        }
//    }
//
//    private lazy var regions = [Region]()
//    private var region: Region?
//    private var type: String = ""

    // MARK: - Initialization

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = fetchResultController?.sections {
            return sections.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchResultController?.sections {
            return sections[section].numberOfObjects
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "regionCell", for: indexPath) as! RegionTableViewCell
        
        if let region = fetchResultController?.object(at: indexPath) {
            cell.configureCell(region: region)
        }

        return cell
 }

    // MARK: - private
    
    private func loadData() {
        fetchResultController = WineService.getRegions(moc: coreData.persistentContainer.viewContext)
    }
}


