//
//  AppManager.swift
//  ArticuLearn
//
//  Created by azibai loc on 06/12/2023.
//

import Foundation
import UIKit

class AppManager {
    
    static let `default` = AppManager()
    
    var lastWindow: UIWindow? {
        return getLastWindow()
    }
    
    private func getLastWindow() -> UIWindow? {
        if #available(iOS 15.0, *) {
            let scenes = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let window = scenes?.windows.last
            
            return window
        } else {
            let window = UIApplication.shared.windows.last
            return window
        }
    }
    
    func openAppSettings() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
    }
    
    func getInitialViewController() -> UIViewController {
        let viewModel = SplashViewModel()
        let viewController = SplashViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}
