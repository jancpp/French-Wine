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

    // MARK: - Property
    
    private lazy var regionTypes = [Region]()
    var region: Region?
    private var type: String?
    
    weak var moc: NSManagedObjectContext! {
        didSet {
            region = Region(context: moc)
            type = Region(context: moc).type
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadDetails()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regionTypes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailTableViewCell

        let typeRegion = regionTypes[indexPath.row]
        cell.configureCell(typeRegion: typeRegion)

        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Private
    
    private func loadDetails() {
        guard
            let region = region,
            let regionType = type
            else {return}
        regionTypes = region.getRegionsByType(type: regionType, moc: moc)
    }

}
