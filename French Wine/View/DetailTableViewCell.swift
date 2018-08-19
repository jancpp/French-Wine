//
//  DetailTableViewCell.swift
//  French Wine
//
//  Created by Jan Polzer on 8/16/18.
//  Copyright © 2018 Apps KC. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var varietiesTextView: UITextView!
    @IBOutlet weak var summaryTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(typeRegion: Region) {
        typeLabel.text = typeRegion.type
        varietiesTextView.text = ""
        summaryTextView.text = typeRegion.summary
        
    }

}
