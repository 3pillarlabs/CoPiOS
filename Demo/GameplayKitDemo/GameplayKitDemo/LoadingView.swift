//
//  LoadingView.swift
//  GameplayKitDemo
//
//  Created by David Livadaru on 16/11/2017.
//  Copyright © 2017 3Pillar Global. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    private var activityIndicator: UIActivityIndicatorView!

    var isLoading: Bool {
        return activityIndicator.isAnimating
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        initializeSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        initializeSubviews()
    }

    func startLoading() {
        activityIndicator.startAnimating()
    }

    func stopLoading() {
        activityIndicator.stopAnimating()
    }

    private func initializeSubviews() {
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
