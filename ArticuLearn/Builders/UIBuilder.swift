//
//  UIBuilder.swift
//  ArticuLearn
//
//  Created by azibai loc on 25/12/2023.
//

import UIKit

protocol UIBuilder {
    associatedtype BuildResult: UIView
    var view: BuildResult { get set }
    func build() -> BuildResult
}

extension UIBuilder {
    func withBackgroundColor(_ color: UIColor) -> Self {
        view.backgroundColor = color
        return self
    }

    func withCornerRadius(_ cornerRadius: CGFloat) -> Self {
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = true
        return self
    }

    func withBorder(width: CGFloat, color: UIColor) -> Self {
        view.layer.borderWidth = width
        view.layer.borderColor = color.cgColor
        return self
    }

    func add(to superview: UIView) -> Self {
        superview.addSubview(view)
        return self
    }

}
