//
//  Collection+Extensions.swift
//  ArticuLearn
//
//  Created by azibai loc on 25/12/2023.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
