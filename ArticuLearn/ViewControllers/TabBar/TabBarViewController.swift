//
//  TabBarViewController.swift
//  ArticuLearn
//
//  Created by azibai loc on 07/12/2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    private let dependencies: TabBarViewControllerDependencies
    
    init(dependencies: TabBarViewControllerDependencies = DefaultTabBarViewControllerDependencies()) {
        
        self.dependencies = dependencies
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        dependencies.tabBarAppearanceManager.configureTabBarAppearance(for: tabBar)
        dependencies.customTabBarViewHandler.addCustomTabBarView(to: tabBar, in: view)
        viewControllers = dependencies.tabBarControllerConfigurator.tabBarViewControllers
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dependencies.customTabBarViewHandler.adjustTabBarFrame(for: tabBar, in: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dependencies.navigationBarVisibilityManager.adjustNavigationBarVisibilityIfNeeded(for: self,
                                                                             hideNavigationBarIfNeeded: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        dependencies.navigationBarVisibilityManager.restorePreviousNavigationBarVisibility(for: self)
    }
}
