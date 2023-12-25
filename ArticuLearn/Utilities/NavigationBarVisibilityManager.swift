//
//  NavigationBarVisibilityManager.swift
//  ArticuLearn
//
//  Created by azibai loc on 08/12/2023.
//

import Foundation
import UIKit
protocol NavigationBarVisibilityAdjustable {
    func adjustNavigationBarVisibilityIfNeeded(for viewController: UIViewController, hideNavigationBarIfNeeded: Bool)
    func restorePreviousNavigationBarVisibility(for viewController: UIViewController)
}
class NavigationBarVisibilityManager: NavigationBarVisibilityAdjustable {
    
    private var isNavigationBarHidden = false
    private var hideNavigationBarIfNeeded = false
    
    func adjustNavigationBarVisibilityIfNeeded(for viewController: UIViewController, hideNavigationBarIfNeeded: Bool) {
        self.hideNavigationBarIfNeeded = hideNavigationBarIfNeeded
        let isPreviousNavBarHidden = viewController.navigationController?.isNavigationBarHidden ?? false
        if isPreviousNavBarHidden != hideNavigationBarIfNeeded {
            isNavigationBarHidden = isPreviousNavBarHidden
            viewController.navigationController?.setNavigationBarHidden(hideNavigationBarIfNeeded, animated: true)
        }
    }
    
    func restorePreviousNavigationBarVisibility(for viewController: UIViewController) {
        if isNavigationBarHidden != hideNavigationBarIfNeeded {
            viewController.navigationController?.setNavigationBarHidden(isNavigationBarHidden, animated: true)
        }
    }
}
