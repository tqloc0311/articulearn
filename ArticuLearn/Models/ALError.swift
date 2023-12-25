//
//  ALError.swift
//  ArticuLearn
//
//  Created by azibai loc on 25/12/2023.
//

import Foundation

enum ALError: Error {
    case message(String)
    case unknown

    var localizedDescription: String {
        switch self {
        case .message(let string):
            return string
        case .unknown:
            return "Unknown error".localized
        }
    }
}

public extension Error {

    var localizedDescription: String {
        if let error = self as? ALError {
            return error.localizedDescription
        } else {
            return self.localizedDescription
        }
    }
}
