//
//  ScrollViewBuilder.swift
//  ArticuLearn
//
//  Created by azibai loc on 25/12/2023.
//

import UIKit

class ScrollViewBuilder: UIBuilder {
    internal var view = UIScrollView()
    
    func withSubview(_ subview: UIView) -> Self {
        view.addSubview(subview)
        return self
    }

    func withScrollIndicator(vertical: Bool, horizontal: Bool) -> Self {
        view.showsVerticalScrollIndicator = vertical
        view.showsHorizontalScrollIndicator = horizontal
        return self
    }

    func withDelegate(_ delegate: UIScrollViewDelegate) -> Self {
        view.delegate = delegate
        return self
    }

    func build() -> UIScrollView {
        return view
    }
}
