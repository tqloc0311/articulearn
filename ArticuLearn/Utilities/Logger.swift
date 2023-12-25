//
//  Logger.swift
//  ArticuLearn
//
//  Created by Loc Tran on 24/12/2023.
//

import Foundation
import os

enum LogType {
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
            logger.info("\(message)")
        case .warning:
            logger.warning("\(message)")
        case .error:
            logger.error("\(message)")
        case .debug:
            logger.debug("\(message)")
        }
    }
    
}

let Log = ConsoleLogger()
