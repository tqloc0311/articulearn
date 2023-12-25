//
//  StackViewBuilder.swift
//  ArticuLearn
//
//  Created by azibai loc on 25/12/2023.
//

import UIKit

class StackViewBuilder: UIBuilder {
    internal var view = UIStackView()

    func withArrangedSubviews(_ arrangedSubviews: [UIView]) -> Self {
        view.arrangedSubviews.forEach { $0.removeFromSuperview() }
        arrangedSubviews.forEach { view.addArrangedSubview($0) }
        return self
    }

    func withAxis(_ axis: NSLayoutConstraint.Axis) -> Self {
        view.axis = axis
        return self
    }

    func withDistribution(_ distribution: UIStackView.Distribution) -> Self {
        view.distribution = distribution
        return self
    }

    func withAlignment(_ alignment: UIStackView.Alignment) -> Self {
        view.alignment = alignment
        return self
    }

    func withSpacing(_ spacing: CGFloat) -> Self {
        view.spacing = spacing
        return self
    }

    func build() -> UIStackView {
        return view
    }
}
