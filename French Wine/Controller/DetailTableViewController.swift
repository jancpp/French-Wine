//
//  DetailTableViewController.swift
//  French Wine
//
//  Created by Jan Polzer on 8/16/18.
//  Copyright © 2018 Apps KC. All rights reserved.
//

import UIKit
import CoreData

class DetailTableViewController: UITableViewController {
        
    private var coreData = CoreDataStack()
    
    // MARK: - Properties
    
    private lazy var regionTypes = [Region]()
    private lazy var varieties = [Variety]()
    private var wineService: WineService?
    
    var managedObjectContext: NSManagedObjectContext? {
        didSet {
            if let moc = managedObjectContext {
                wineService = WineService(moc: moc)
            }
        }
    }
    
    var selectedRegion: Region? {
        didSet {
            loadDetails()
        }
    }
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedRegion?.name ?? "French wine"

        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if regionTypes.count > 0 {
            return regionTypes.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailTableViewCell
        
        cell.configureCell(region: regionTypes[indexPath.row], varieties: varieties)
        
        return cell
    }
    
    // MARK: - Private
    
    private func loadDetails() {
        guard
            let selectedRegion = selectedRegion
            else {return}
        if let regions = wineService?.getTypesOfRegion(region: selectedRegion) {
            regionTypes = regions
        }
    }
    
    
}
