//
//  NotesTableViewController.swift
//  French Wine
//
//  Created by Jan Polzer on 1/1/19.
//  Copyright © 2019 Apps KC. All rights reserved.
//

import UIKit
import CoreData

class NotesTableViewController: UITableViewController {

    // MARK: - Properties
    
    private var coreData = CoreDataStack()
    weak var managedObjectContext: NSManagedObjectContext!
    private lazy var notes = [Note]()
    private var selectedRegion: Region? {
        didSet {
            loadNotes()
        }
    }
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadNotes()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)

        cell.textLabel?.text = notes[indexPath.row].body

        return cell
    }
    
    // MARK: - Private
    private func loadNotes() {
        let tabBar = tabBarController as! BaseTabBarController
        guard
            let selectedRegion = tabBar.selectedRegion
            else {return}
        if let noteList = WineService.getNotes(moc: coreData.persistentContainer.viewContext, region: selectedRegion) {
            notes = noteList
            tableView.reloadData()
        }
    }

}
