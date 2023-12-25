//
//  TabBarControllerConfigurator.swift
//  ArticuLearn
//
//  Created by azibai loc on 08/12/2023.
//

import UIKit

protocol TabBarControllerConfiguring {
    var tabBarViewControllers: [UIViewController] { get }
}

class TabBarControllerConfigurator: TabBarControllerConfiguring {
    lazy var tabBarViewControllers: [UIViewController] = {
        return [
            configureHomeViewController(),
            configureHistoryViewController(),
            configureSettingsViewController()
        ]
    }()
    
    private func embedInNavigationController(with viewController: UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: viewController)
    }
    
    private func configureHomeViewController() -> UIViewController {
        let homeViewController = HomeViewController(viewModel: HomeViewModel())
        homeViewController.tabBarItem.image = UIImage(named: "home_tabbar_icon")
        homeViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        return embedInNavigationController(with: homeViewController)
    }

    private func configureHistoryViewController() -> UIViewController {
        let historyViewController = HistoryViewController(viewModel: HistoryViewModel())
        historyViewController.tabBarItem.image = UIImage(named: "history_tabbar_icon")
        historyViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        return embedInNavigationController(with: historyViewController)
    }

    private func configureSettingsViewController() -> UIViewController {
        let settingsViewController = SettingsViewController(viewModel: SettingsViewModel())
        settingsViewController.tabBarItem.image = UIImage(named: "settings_tabbar_icon")
        settingsViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        return embedInNavigationController(with: settingsViewController)
    }
}

