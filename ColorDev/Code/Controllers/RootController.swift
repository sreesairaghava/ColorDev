//
//  RootController.swift
//  ColorDev
//
//  Created by Sree Sai Raghava Dandu on 16/06/22.
//

import UIKit

class RootController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .cyan
            self.tabBarController?.tabBar.standardAppearance = appearance
        }
    }

}
