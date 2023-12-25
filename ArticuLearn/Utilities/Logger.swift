//
//  Logger.swift
//  ArticuLearn
//
//  Created by Loc Tran on 24/12/2023.
//

import Foundation
import os

enum LogType: String {
    case info, warning, error, debug
}

protocol Loggable {
    func log(type: LogType, message: String)
}

struct ConsoleLogger: Loggable {
    private let logger = Logger()

    func log(type: LogType = .debug, message: String) {
        switch type {
        case .info:
            logger.info("\(type.rawValue.uppercased()): \(message)")
        case .warning:
            logger.warning("\(type.rawValue.uppercased()): \(message)")
        case .error:
            logger.error("\(type.rawValue.uppercased()): \(message)")
        case .debug:
            logger.debug("\(type.rawValue.uppercased()): \(message)")
        }
    }
}

let Log = ConsoleLogger()
