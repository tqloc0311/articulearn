//
//  NavigationBarAppearanceManager.swift
//  ArticuLearn
//
//  Created by azibai loc on 08/12/2023.
//

import UIKit

class NavigationBarAppearanceManager {
    func configureNavigationBarAppearance(navigationBar: UINavigationBar?,
                                          navigationItem: UINavigationItem,
                                          hideBackButtonIfNeeded: Bool) {
        navigationBar?.backgroundColor = .white
        navigationBar?.isTranslucent = true
        
        navigationBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.primary]
        
        if hideBackButtonIfNeeded {
            navigationItem.leftBarButtonItem = nil
        }
    }
}
