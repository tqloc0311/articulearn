//
//  AlertConfig.swift
//  ArticuLearn
//
//  Created by azibai loc on 07/12/2023.
//

import Foundation

enum PermissionType: String {
    case microphone = "Microphone"
    case speechRecognition = "Speech Recognition"
}

enum AlertType {
    case permission(permissionType: PermissionType)
    case message(message: String)
    case titleAndMessage(title: String, message: String)
    case unknownError
}

struct AlertConfig {
    var title: String
    var message: String
    var cancelButtonTitle: String?
    var confirmButtonTitle: String
    var onComfirm: (() -> Void)?
}
