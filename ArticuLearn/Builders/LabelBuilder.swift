//
//  LabelBuilder.swift
//  ArticuLearn
//
//  Created by azibai loc on 25/12/2023.
//

import UIKit

class LabelBuilder: UIBuilder {
    internal var view = UILabel()

    func withText(_ text: String) -> Self {
        view.text = text
        return self
    }

    func withFont(_ font: UIFont) -> Self {
        view.font = font
        return self
    }

    func withTextColor(_ color: UIColor) -> Self {
        view.textColor = color
        return self
    }

    func withAlignment(_ alignment: NSTextAlignment) -> Self {
        view.textAlignment = alignment
        return self
    }

    func withNumberOfLines(_ numberOfLines: Int) -> Self {
        view.numberOfLines = numberOfLines
        return self
    }

    func add(to view: UIView) -> Self {
        view.addSubview(view)
        return self
    }

    func build() -> UILabel {
        return view
    }
}
