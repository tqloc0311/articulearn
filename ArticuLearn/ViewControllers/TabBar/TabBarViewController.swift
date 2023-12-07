//
//  TabBarViewController.swift
//  ArticuLearn
//
//  Created by azibai loc on 07/12/2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    private var isNavigationBarHidden = false
    private let hideNavigationBarIfNeeded = true
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let isPreviousNavBarHidden = navigationController?.isNavigationBarHidden ?? false
        if isPreviousNavBarHidden != hideNavigationBarIfNeeded {
            isNavigationBarHidden = isPreviousNavBarHidden
            navigationController?.setNavigationBarHidden(hideNavigationBarIfNeeded, animated: animated)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isNavigationBarHidden != hideNavigationBarIfNeeded {
            navigationController?.setNavigationBarHidden(isNavigationBarHidden, animated: animated)
        }
    }
    
    func setupViewControllers() {
        
        tabBar.tintColor = .primary
        
        let homeViewController = HomeViewController(viewModel: HomeViewModel())
        homeViewController.tabBarItem.image = UIImage(named: "home_tabbar_icon")
        homeViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)

        let historyViewController = HistoryViewController(viewModel: HistoryViewModel())
        historyViewController.tabBarItem.image = UIImage(named: "history_tabbar_icon")
        historyViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        let settingsViewController = SettingsViewController(viewModel: SettingsViewModel())
        settingsViewController.tabBarItem.image = UIImage(named: "settings_tabbar_icon")
        settingsViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        viewControllers = [
            embedInNavigationController(with: homeViewController),
            embedInNavigationController(with: historyViewController),
            embedInNavigationController(with: settingsViewController)]
    }
    
    private func embedInNavigationController(with viewController: UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: viewController)
    }
}
