//
//  TabBarViewControllerDependencies.swift
//  ArticuLearn
//
//  Created by azibai loc on 08/12/2023.
//

import Foundation

protocol TabBarViewControllerDependencies {
    var tabBarAppearanceManager: TabBarAppearanceConfigurable { get }
    var navigationBarVisibilityManager: NavigationBarVisibilityAdjustable { get }
    var tabBarControllerConfigurator: TabBarControllerConfiguring { get }
    var customTabBarViewHandler: CustomTabBarViewAdjustable { get }
}

struct DefaultTabBarViewControllerDependencies: TabBarViewControllerDependencies {
    var tabBarAppearanceManager: TabBarAppearanceConfigurable = TabBarAppearanceManager()
    var navigationBarVisibilityManager: NavigationBarVisibilityAdjustable = NavigationBarVisibilityManager()
    var tabBarControllerConfigurator: TabBarControllerConfiguring = TabBarControllerConfigurator()
    var customTabBarViewHandler: CustomTabBarViewAdjustable = CustomTabBarViewHandler()
}

