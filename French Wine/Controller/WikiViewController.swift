//
//  WikiViewController.swift
//  French Wine
//
//  Created by Jan Polzer on 12/30/18.
//  Copyright © 2018 Apps KC. All rights reserved.
//

import UIKit
import CoreData
import SafariServices

class WikiViewController: UIViewController, UIWebViewDelegate {
    
    // MARK: - Properties
    
    private var url: String?
    private var wineService: WineService?
    
    var selectedRegion: Region? {
        didSet {
            loadData()
        }
    }
    
    var managedObjectContext: NSManagedObjectContext? {
        didSet {
            if let moc = managedObjectContext {
                wineService = WineService(moc: moc)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: View Controller Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showWebsite(url: url ?? "https://en.wikipedia.org/wiki/French_wine")
    }

    // MARK: - Private
    
    private func showWebsite(url: String) {
        guard
            let url = URL(string: url)
            else {return}
        let webVC = SFSafariViewController(url: url as URL)
        webVC.delegate = self
        
        present(webVC, animated: true, completion: nil)
    }
    
    private func loadData() {
        if let region = selectedRegion {
            url = wineService?.getUrl(region: region)
        }
    }
}

extension WikiViewController: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        
        controller.dismiss(animated: true, completion: nil)
        
        tabBarController?.selectedIndex = 0
    }
}
