//
//  CollectionViewCellV2.swift
//  SelfSizingCollectionViewCells
//
//  Created by David Livadaru on 24/01/2020.
//  Copyright © 2020 3Pillar Global. All rights reserved.
//

import UIKit

class CollectionViewCellV2: UICollectionViewCell {
    @IBOutlet private(set) weak var imageView: UIImageView!
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var descriptionLabel: UILabel!

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        layoutAttributes.frame.size = size
        return layoutAttributes
    }
}
