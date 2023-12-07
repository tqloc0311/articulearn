//
//  AlertPresenter.swift
//  ArticuLearn
//
//  Created by azibai loc on 06/12/2023.
//

import UIKit

protocol AlertPresenter {
    func showAlert(for alertType: AlertType)
}

class NativeAlertPresenter {
    
    static let `default` = NativeAlertPresenter()
    
    private func configure(for alertType: AlertType) -> AlertConfig {
        let config: AlertConfig
        
        switch alertType {
        case .permission(let permissionType):
            config = .init(title: "Permission Required".localized,
                           message: "\(permissionType.rawValue) permission is required for this feature. Please enable it in Settings.".localized,
                           cancelButtonTitle: "Cancel".localized,
                           confirmButtonTitle: "Settings".localized, onComfirm: {
                AppManager.default.openAppSettings()
            })
        case .message(let message):
            config = .init(title: "Notification".localized,
                           message: message,
                           cancelButtonTitle: "Cancel".localized,
                           confirmButtonTitle: "OK".localized)
        case .titleAndMessage(let title, let message):
                            config = .init(title: title,
                                           message: message,
                                           cancelButtonTitle: "Cancel".localized,
                                           confirmButtonTitle: "OK".localized)
        case .unknownError:
            config = .init(title: "Error".localized,
                           message: "An unknown error has occurred. Please try again later.".localized,
                           confirmButtonTitle: "OK".localized)
        }
        
        return config
    }
    
}

extension NativeAlertPresenter: AlertPresenter {
    func showAlert(for alertType: AlertType) {
        let configuration = configure(for: alertType)
        let alertController = UIAlertController(
            title: configuration.title,
            message: configuration.message,
            preferredStyle: .alert
        )
        
        if let cancelButtonTitle = configuration.cancelButtonTitle {
            alertController.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil))
        }
        alertController.addAction(UIAlertAction(title: configuration.confirmButtonTitle, style: .default, handler: { _ in
            configuration.onComfirm?()
        }))
        
        AppManager.default.lastWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}
