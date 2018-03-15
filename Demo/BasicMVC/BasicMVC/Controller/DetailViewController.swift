//
//  DetailViewController.swift
//  BasicMVC
//
//  Created by David Livadaru on 05/03/2018.
//  Copyright © 2018 David Livadaru. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var descriptionLabel: UILabel!
    private let date: Date

    init(date: Date) {
        self.date = date

        super.init(nibName: "DetailViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Decoding from storyboard is not supported.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        let dateFormmater = DateFormatter()
        dateFormmater.dateStyle = .full
        dateFormmater.timeStyle = .full
        descriptionLabel.text = dateFormmater.string(from: date)
    }
}
