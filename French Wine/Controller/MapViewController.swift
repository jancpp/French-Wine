//
//  MapViewController.swift
//  French Wine
//
//  Created by Jan Polzer on 12/30/18.
//  Copyright © 2018 Apps KC. All rights reserved.
//

import UIKit
import CoreData
import SafariServices

class MapViewController: UIViewController, UIWebViewDelegate {
    
    private var mapUrl: String?
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
    
    override func awakeFromNib() {
    }
    
    // MARK: View Controller Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showMap(mapUrl: mapUrl ?? "https://upload.wikimedia.org/wikipedia/commons/2/29/Cartes_des_vins_de_france.png")
        
    }
    
    // MARK: - Private
    
    private func showMap(mapUrl: String) {
        guard let mapUrl = URL(string: mapUrl)
            else {return}
        let webVC = SFSafariViewController(url: mapUrl as URL)
        webVC.delegate = self
        
        present(webVC, animated: true, completion: nil)
    }
    
    private func loadData() {
        guard let region = selectedRegion
            else {return}
        mapUrl = wineService?.getMapUrl(region: region)
        
    }
}

extension MapViewController: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        
        controller.dismiss(animated: true, completion: nil)
        
        tabBarController?.selectedIndex = 0
    }
}
