//
//  String+Localized.swift
//  ArticuLearn
//
//  Created by azibai loc on 06/12/2023.
//

import Foundation

extension String {

  var localized: String {
    return NSLocalizedString(self, comment: "\(self)_comment")
  }
  
  func localized(_ args: [CVarArg]) -> String {
    return localized(args)
  }
  
  func localized(_ args: CVarArg...) -> String {
    return String(format: localized, args)
  }
}
