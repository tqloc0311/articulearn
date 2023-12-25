//
//  ButtonBuilder.swift
//  ArticuLearn
//
//  Created by azibai loc on 25/12/2023.
//

import UIKit

class ButtonBuilder: UIBuilder {
    typealias BuildResult = UIButton

    internal var view = UIButton(type: .system)

    func withTitle(_ title: String, for state: UIControl.State = .normal) -> Self {
        view.setTitle(title, for: state)
        return self
    }

    func withTintColor(_ color: UIColor) -> Self {
        view.tintColor = color
        return self
    }

    func withTitleColor(_ color: UIColor, for state: UIControl.State = .normal) -> Self {
        view.setTitleColor(color, for: state)
        return self
    }

    func withFont(_ font: UIFont) -> Self {
        view.titleLabel?.font = font
        return self
    }

    func withTarget(_ target: Any?, action: Selector, for event: UIControl.Event) -> Self {
        view.addTarget(target, action: action, for: event)
        return self
    }

    func withLeftIcon(_ image: UIImage?, contentMode: UIView.ContentMode = .scaleAspectFit) -> Self {
        var configuration = UIButton.Configuration.plain()
        configuration.image = image
        configuration.titlePadding = 10
        configuration.imagePadding = 10
        view.configuration = configuration
        return self
    }

    func build() -> UIButton {
        return view
    }
}
