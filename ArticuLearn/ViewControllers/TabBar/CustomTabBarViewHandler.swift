//
//  CustomTabBarViewHandler.swift
//  ArticuLearn
//
//  Created by azibai loc on 08/12/2023.
//

import UIKit

protocol CustomTabBarViewAdjustable {
    func adjustTabBarFrame(for tabBar: UITabBar, in view: UIView)
    func addCustomTabBarView(to tabBar: UITabBar, in view: UIView)
}

class CustomTabBarViewHandler: CustomTabBarViewAdjustable {
    
    private var customTabBarView = UIView(frame: .zero)
    
    func adjustTabBarFrame(for tabBar: UITabBar, in view: UIView) {
        let height = view.safeAreaInsets.bottom + 64
        var tabFrame = tabBar.frame
        tabFrame.size.height = height
        tabFrame.origin.y = view.frame.size.height - height
        tabBar.frame = tabFrame
        tabBar.setNeedsLayout()
        tabBar.layoutIfNeeded()
        
        customTabBarView.frame = tabBar.frame
    }

    func addCustomTabBarView(to tabBar: UITabBar, in view: UIView) {
        customTabBarView = UIView(frame: tabBar.frame)
        customTabBarView.backgroundColor = .white
        customTabBarView.layer.cornerRadius = 30
        customTabBarView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        customTabBarView.layer.masksToBounds = false
        customTabBarView.layer.shadowColor = UIColor.black.cgColor
        customTabBarView.layer.shadowOffset = CGSize(width: -4, height: -6)
        customTabBarView.layer.shadowOpacity = 0.06
        customTabBarView.layer.shadowRadius = 16
        view.addSubview(customTabBarView)
        view.bringSubviewToFront(tabBar)
    }
}

