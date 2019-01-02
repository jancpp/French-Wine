//
//  NoteTableViewCell.swift
//  French Wine
//
//  Created by Jan Polzer on 1/2/19.
//  Copyright © 2019 Apps KC. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var noteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(note: Note) {
        noteLabel.text = note.body
    }

}
