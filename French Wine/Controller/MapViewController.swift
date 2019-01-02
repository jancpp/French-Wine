//
//  MapViewController.swift
//  French Wine
//
//  Created by Jan Polzer on 12/30/18.
//  Copyright © 2018 Apps KC. All rights reserved.
//

import UIKit
import SafariServices

class MapViewController: UIViewController, UIWebViewDelegate {
    
    //    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var selectedRegion: Region?
    var mapUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func awakeFromNib() {
    }
    
    // MARK: View Controller Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
        showImage(mapUrl: mapUrl ?? "https://upload.wikimedia.org/wikipedia/commons/2/29/Cartes_des_vins_de_france.png")
        
    }
    
    // MARK: - Private
    
    private func showImage(mapUrl: String) {
        guard
            let mapUrl = URL(string: mapUrl)
            else {return}
        let webVC = SFSafariViewController(url: mapUrl as URL)
        webVC.delegate = self
        
        present(webVC, animated: true, completion: nil)
    }
    
    private func loadData() {
        if let tabBar = tabBarController as? BaseTabBarController {
            guard
                let selectedRegion = tabBar.selectedRegion
                else {return}
            
            mapUrl = WineService.getImageUrl(region: selectedRegion)
        }
    }
}

extension MapViewController: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        
        controller.dismiss(animated: true, completion: nil)
        
        tabBarController?.selectedIndex = 0
    }
}
