//
//  NotesTableViewController.swift
//  French Wine
//
//  Created by Jan Polzer on 1/1/19.
//  Copyright © 2019 Apps KC. All rights reserved.
//

import UIKit
import CoreData

typealias NoteHandler = (Bool, [Note]) -> ()

class NotesTableViewController: UITableViewController {

    
    // MARK: - Properties
    
    private var coreData = CoreDataStack()
    private var noteToUpdate: Note?
    private var noteList = [Note]()
    private var note: Note?
    private var wineService: WineService?
    
    var managedObjectContext: NSManagedObjectContext? {
        didSet {
            if let moc = managedObjectContext {
                wineService = WineService(moc: moc)
            }
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func addNoteButton(_ sender: Any) {
        present(alertController(actionType: "Add"), animated: true, completion: nil)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Notes"
        loadNotes()
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func awakeFromNib() {
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteTableViewCell
        cell.configureCell(note: noteList[indexPath.row])
        
        return cell
    }
    
    // MARK: - Private functions
    
    private func alertController(actionType: String) -> UIAlertController {
        
        let alertController = UIAlertController(title: "New note", message: "Add a note", preferredStyle: UIAlertController.Style.alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Write a note"
        }
        
        let defaultAction = UIAlertAction(title: actionType, style: UIAlertAction.Style.default, handler: { alert -> Void in
            guard
                let body = alertController.textFields![0].text
                else {return}
            
            if actionType == "Add" {
                self.wineService?.addNote(body: body, completion: { (success, notes) in
                    if success {
                        self.noteList = notes
                    }
                })
            }
            
            DispatchQueue.main.async {
                self.loadNotes()
            }
        })
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in
            self.noteToUpdate = nil
        })
        
        alertController.addAction(defaultAction)
        alertController.addAction(cancelAction)
        
        return alertController
    }
    
//    private func saveNote(completion: ((Bool) -> Void)? = nil) {
//        let success: Bool
//        
//        do {
//            try managedObjectContext.save()
//            success = true
//        }
//        catch let error as NSError {
//            print("Save failed: \(error.localizedDescription)")
//            managedObjectContext.rollback()
//            success = false
//        }
//        
//        if let completion = completion {
//            completion(success)
//        }
//    }
    
    // MARK: - CRUD Functions
    
    private func loadNotes() {
        
        if let notes = wineService?.getNotes() {
            noteList = notes
            tableView.reloadData()
        }
    }
}
