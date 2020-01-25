//
//  CollectionViewCell.swift
//  SelfSizingCollectionViewCells
//
//  Created by David Livadaru on 24/01/2020.
//  Copyright © 2020 3Pillar Global. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet private(set) weak var imageView: UIImageView!
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var descriptionLabel: UILabel!
    @IBOutlet private weak var stackViewWidth: NSLayoutConstraint!

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        if #available(iOS 13, *) {} else {
            updateConstraintsIfNeeded()
        }
        stackViewWidth.constant = layoutAttributes.size.width
        return super.preferredLayoutAttributesFitting(layoutAttributes)
    }
}
