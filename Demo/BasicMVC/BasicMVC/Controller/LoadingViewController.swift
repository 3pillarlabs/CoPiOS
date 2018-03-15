//
//  LoadingViewController.swift
//  BasicMVC
//
//  Created by David Livadaru on 05/03/2018.
//  Copyright © 2018 David Livadaru. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        activityIndicator.startAnimating()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        activityIndicator.stopAnimating()
    }
}
