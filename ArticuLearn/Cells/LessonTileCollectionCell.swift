//
//  LessonTileCollectionCell.swift
//  ArticuLearn
//
//  Created by azibai loc on 25/12/2023.
//

import Foundation
import SnapKit

class LessonTileCollectionCell: CollectionViewCell {
    
    private let titleLabel = LabelBuilder()
        .withFont(.boldSystemFont(ofSize: 18))
        .withNumberOfLines(0)
        .build()
    
    private let contentTextView = TextViewBuilder()
        .withScrollIndicator(vertical: false, horizontal: false)
        .withEditable(false)
        .withFont(.systemFont(ofSize: 16))
        .build()
    
    override func makeUI() {
        super.makeUI()
        
        let stackView = StackViewBuilder()
            .withArrangedSubviews([titleLabel, contentTextView])
            .withAxis(.vertical)
            .withDistribution(.fill)
            .withSpacing(8)
            .add(to: contentView)
            .build()
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(with lesson: Lesson) {
        titleLabel.text = lesson.title
        contentTextView.text = lesson.content
    }
}
