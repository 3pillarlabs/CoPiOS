//
//  DetailViewController.swift
//  Operations
//
//  Created by Dorel Macra on 29/08/2017.
//
//

import UIKit

class DetailViewController: UIViewController {
    var json: JSONType?

    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let json = json {
            textView.text = String(describing: json)
        }
    }
}

