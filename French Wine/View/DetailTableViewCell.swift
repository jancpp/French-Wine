//
//  DetailTableViewCell.swift
//  French Wine
//
//  Created by Jan Polzer on 8/16/18.
//  Copyright © 2018 Apps KC. All rights reserved.
//

import UIKit
import CoreData

class DetailTableViewCell: UITableViewCell {
    
    private var coreData = CoreDataStack()
    
    // MARK: - Outlets
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var varietiesLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    // MARK: Properties
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(region: Region, varieties: [Variety]) {
        
        var typeStr: String = region.type ?? ""
        typeStr.append(" wine")
        typeLabel.text = typeStr.localizedUppercase
        typeLabel.font = UIFont.boldSystemFont(ofSize: typeLabel.font.pointSize)
        
        var summaryStr: String = "Summary:\n"
        if let summary = region.summary {
            summaryStr.append(summary)
            summaryLabel.text = summaryStr
        }
        
        var varieties = [Variety]()
        varieties = region.varieties?.allObjects as! [Variety]
        var varietiesStr: String = "Varieties:\n"
        // Append varieties, seperated by comma
        if varieties.count > 0 {
            for variety in varieties.prefix(varieties.count - 1) {
                varietiesStr.append("\(variety.name ?? ""), ")
            }
            varietiesStr.append("\(varieties[varieties.count - 1].name ?? "")")
        }
        varietiesLabel.text = varietiesStr
    }
    
    func adjustTextViewHeight(textView : UITextView) {
        textView.sizeToFit()
        textView.isScrollEnabled = false
    }
}
