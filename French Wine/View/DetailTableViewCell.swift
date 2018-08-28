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
    @IBOutlet weak var varietiesTextView: UITextView!
    @IBOutlet weak var summaryTextView: UITextView!
    
    // MARK: Properties
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(region: Region, varieties: [Variety]) {
        
        typeLabel.text = region.type?.localizedUppercase
        typeLabel.font = UIFont.boldSystemFont(ofSize: typeLabel.font.pointSize)
        
        var summaryStr: String = "Summary:\n"
        summaryTextView.textContainer.maximumNumberOfLines = 10
        summaryTextView.textContainer.lineBreakMode = .byTruncatingTail
        if let summary = region.summary {
            summaryStr.append(summary)
            summaryTextView.text = summaryStr
        }
        adjustTextViewHeight(textView : summaryTextView)
        
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
        varietiesTextView.text = varietiesStr
        adjustTextViewHeight(textView : varietiesTextView)
    }
    
    func adjustTextViewHeight(textView : UITextView)
    {
//        textView.translatesAutoresizingMaskIntoConstraints = true
        textView.sizeToFit()
        textView.isScrollEnabled = false
    }
}
