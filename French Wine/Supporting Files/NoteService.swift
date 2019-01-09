//
//  NoteService.swift
//  French Wine
//
//  Created by Jan Polzer on 1/3/19.
//  Copyright © 2019 Apps KC. All rights reserved.
//

import Foundation
import CoreData

typealias NoteHandler = (Bool, [Note]) -> ()


class NoteService {
    
    // READ
    static func getNotes(moc: NSManagedObjectContext) -> [Note] {
        
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        var notes = [Note]()

        do {
            notes = try moc.fetch(request)
        }
        catch let error as NSError {
            print("Error fetching notes: \(error.localizedDescription)")
        }
        return notes
    }
    
    // CREATE
    static func addNote(moc: NSManagedObjectContext, body: String, completion: NoteHandler) {
        
//        let note = Note(context: moc)
//        note.body = body
//        notes.append(note)
//        completion(true, notes)
    }
    
    // MARK: - Private functions
    
    private func saveNote(completion: ((Bool) -> Void)? = nil) {
//        let success: Bool
//
//        do {
//            try moc.save()
//            success = true
//        }
//        catch let error as NSError {
//            print("Save failed: \(error.localizedDescription)")
//            moc.rollback()
//            success = false
//        }
//
//        if let completion = completion {
//            completion(success)
//        }
    }
}
