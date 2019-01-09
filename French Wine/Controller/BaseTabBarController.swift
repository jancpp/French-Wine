//
//  BaseTabBarController.swift
//  French Wine
//
//  Created by Jan Polzer on 1/7/19.
//  Copyright © 2019 Apps KC. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    var selectedRegion: Region?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedRegion?.name ?? "French wine"
    }

}
