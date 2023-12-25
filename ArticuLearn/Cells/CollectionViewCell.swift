//
//  CollectionViewCell.swift
//  ArticuLearn
//
//  Created by azibai loc on 25/12/2023.
//

import UIKit

open class CollectionViewCell: UICollectionViewCell {
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    open func setupUI() {}
}
