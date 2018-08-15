//
//  RegionTableViewCell.swift
//  French Wine
//
//  Created by Jan Polzer on 8/14/18.
//  Copyright © 2018 Apps KC. All rights reserved.
//

import UIKit

class RegionTableViewCell: UITableViewCell {

    @IBOutlet weak var regionNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(region: Region) {
        regionNameLabel.text = region.name
    }

}
