//
//  TextViewBuilder.swift
//  ArticuLearn
//
//  Created by azibai loc on 25/12/2023.
//

import UIKit

class TextViewBuilder: UIBuilder {
    internal lazy var view = {
        let textView = UITextView()
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        return textView
    }()

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

    func withBackgroundColor(_ color: UIColor) -> Self {
        view.backgroundColor = color
        return self
    }

    func withTextAlignment(_ alignment: NSTextAlignment) -> Self {
        view.textAlignment = alignment
        return self
    }

    func withDelegate(_ delegate: UITextViewDelegate) -> Self {
        view.delegate = delegate
        return self
    }

    func withEditable(_ isEditable: Bool) -> Self {
        view.isEditable = isEditable
        return self
    }

    func withScrollIndicator(vertical: Bool, horizontal: Bool) -> Self {
        view.showsVerticalScrollIndicator = vertical
        view.showsHorizontalScrollIndicator = horizontal
        return self
    }

    func withScrollable(_ isScrollEnabled: Bool) -> Self {
        view.isScrollEnabled = isScrollEnabled
        return self
    }

    func build() -> UITextView {
        return view
    }
}
