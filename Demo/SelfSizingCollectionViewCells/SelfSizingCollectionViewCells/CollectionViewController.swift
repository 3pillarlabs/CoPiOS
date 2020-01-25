//
//  CollectionViewController.swift
//  SelfSizingCollectionViewCells
//
//  Created by David Livadaru on 24/01/2020.
//  Copyright © 2020 3Pillar Global. All rights reserved.
//

import UIKit
import Nuke

class CollectionViewController: UICollectionViewController {
    private let dataSource = DataSource()
    private var placeholder: UIImage! { UIImage(named: "placeholder")! }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CollectionViewCell")

        let nib2 = UINib(nibName: "CollectionViewCellV2", bundle: nil)
        collectionView.register(nib2, forCellWithReuseIdentifier: "CollectionViewCellV2")

        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let safeArea = collectionView.bounds.inset(by: collectionView.safeAreaInsets)
        updateEstimatedItemSize(with: safeArea)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        let bounds = CGRect(origin: view.bounds.origin, size: size)
        let safeArea = bounds.inset(by: view.safeAreaInsets)
        updateEstimatedItemSize(with: safeArea)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.objects.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellV2", for: indexPath)

        if let customCell = cell as? CollectionViewCellV2 {
            let forest = dataSource.objects[indexPath.row]
            let options = ImageLoadingOptions(
                placeholder: placeholder, transition: ImageLoadingOptions.Transition.fadeIn(duration: 0.3)
            )
            Nuke.loadImage(with: forest.imageURL, options: options, into: customCell.imageView)
            customCell.titleLabel.text = forest.title
            customCell.descriptionLabel.text = forest.description
        }

        return cell
    }

    private func updateEstimatedItemSize(with rect: CGRect) {
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let sectionSpacing = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let contentSpacing = collectionView.adjustedContentInset.left + collectionView.adjustedContentInset.right
        let insets = sectionSpacing + contentSpacing
        let width = rect.width - insets
        flowLayout.estimatedItemSize = CGSize(width: width, height: 50)
    }
}
