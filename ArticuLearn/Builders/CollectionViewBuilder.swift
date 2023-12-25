//
//  CollectionViewBuilder.swift
//  ArticuLearn
//
//  Created by azibai loc on 25/12/2023.
//

import UIKit

class CollectionViewBuilder: UIBuilder {
    internal var view: UICollectionView

    init(collectionViewLayout: UICollectionViewLayout) {
        self.view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    }

    func withDataSource(_ dataSource: UICollectionViewDataSource) -> Self {
        view.dataSource = dataSource
        return self
    }

    func withDelegate(_ delegate: UICollectionViewDelegate) -> Self {
        view.delegate = delegate
        return self
    }

    func withBackgroundColor(_ backgroundColor: UIColor) -> Self {
        view.backgroundColor = backgroundColor
        return self
    }

    func withRegisterCell<T: UICollectionViewCell>(_ cellClass: T.Type, reuseIdentifier: String) -> Self {
        view.register(cellClass, forCellWithReuseIdentifier: reuseIdentifier)
        return self
    }

    func withFlowLayout(_ flowLayout: UICollectionViewFlowLayout) -> Self {
        view.collectionViewLayout = flowLayout
        return self
    }

    func withPaging(_ isPagingEnabled: Bool) -> Self {
        view.isPagingEnabled = isPagingEnabled
        return self
    }

    func withScrollIndicator(vertical: Bool, horizontal: Bool) -> Self {
        view.showsVerticalScrollIndicator = vertical
        view.showsHorizontalScrollIndicator = horizontal
        return self
    }

    func build() -> UICollectionView {
        return view
    }
}
