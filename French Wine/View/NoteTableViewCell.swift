//
//  NoteTableViewCell.swift
//  French Wine
//
//  Created by Jan Polzer on 1/2/19.
//  Copyright © 2019 Apps KC. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    
    @IBOutlet weak var noteTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(note: Note) {
        noteTextView.textContainer.maximumNumberOfLines = 10
        noteTextView.textContainer.lineBreakMode = .byTruncatingTail
        if let body = note.body {
            noteTextView.text = body
        }
        adjustTextViewHeight(textView: noteTextView)
    }
    
    func adjustTextViewHeight(textView : UITextView) {
        textView.sizeToFit()
        textView.isScrollEnabled = false
    }
}
