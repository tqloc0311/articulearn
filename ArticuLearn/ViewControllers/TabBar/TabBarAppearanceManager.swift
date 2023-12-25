//
//  TabBarAppearanceManager.swift
//  ArticuLearn
//
//  Created by azibai loc on 08/12/2023.
//

import UIKit

protocol TabBarAppearanceConfigurable {
    func configureTabBarAppearance(for tabBar: UITabBar)
}

class TabBarAppearanceManager: TabBarAppearanceConfigurable {
    func configureTabBarAppearance(for tabBar: UITabBar) {
        tabBar.backgroundColor = .white
        tabBar.cornerRadius = 30
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = UIColor.gray
        
        if #available(iOS 13.0, *) {
            let appearance = tabBar.standardAppearance
            appearance.shadowImage = nil
            appearance.shadowColor = nil
            tabBar.standardAppearance = appearance
        } else {
            tabBar.shadowImage = UIImage()
            tabBar.backgroundImage = UIImage()
        }
    }
}
