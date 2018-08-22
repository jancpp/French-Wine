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
    
//    private lazy var varieties = [Variety]()
//    var selectedRegion: Region?
//    private var variety: Variety?
//
//    weak var managedObjectContext: NSManagedObjectContext! {
//        didSet {
//            variety = Variety(context: managedObjectContext)
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(region: Region, varieties: [Variety]) {
        
        typeLabel.text = region.type?.localizedUppercase
        summaryTextView.text = region.summary
        
        var varieties = [Variety]()
        varieties = region.varieties?.allObjects as! [Variety]
        var varietiesStr: String = "Varieties: "
        // Append avrieties, seperated by comma
        if varieties.count > 0 {
            for variety in varieties.prefix(varieties.count - 1) {
                varietiesStr.append("\(variety.name ?? ""), ")
            }
            varietiesStr.append("\(varieties[varieties.count - 1].name ?? "")")
        }
        varietiesTextView.text = varietiesStr
    }
}
