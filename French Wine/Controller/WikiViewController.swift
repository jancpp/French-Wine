//
//  WikiViewController.swift
//  French Wine
//
//  Created by Jan Polzer on 12/30/18.
//  Copyright © 2018 Apps KC. All rights reserved.
//

import UIKit
import SafariServices

class WikiViewController: UIViewController, UIWebViewDelegate {

    // MARK: - Properties
    
    var selectedRegion: Region?
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadDetails()
        showWebsite(url: url ?? "https://en.wikipedia.org/wiki/French_wine")
    }
    
    // MARK: - Private
    
    private func showWebsite(url: String) {
        guard let url = URL(string: url)
            else {return}
        let webVC = SFSafariViewController(url: url as URL)
//        webVC.delegate = self
        
        present(webVC, animated: true, completion: nil)
    }
    
    private func loadDetails() {
        let tabBar = tabBarController as! BaseTabBarController
        guard
            let selectedRegion = tabBar.selectedRegion
            else {return}
        
        url = WineService.getUrl(region: selectedRegion)
    }
}

extension WikiViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
