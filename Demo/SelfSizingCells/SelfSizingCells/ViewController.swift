//
//  ViewController.swift
//  SelfSizingCells
//
//  Created by David Livadaru on 20/07/2017.
//  Copyright © 2017 3Pillar Global. All rights reserved.
//

import UIKit

private typealias StringPair = (one: String, two: String)

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var pairs: [StringPair] = []
    @IBOutlet weak var tableView: UITableView!

    private var cell: TableViewCell!

    override func loadView() {
        super.loadView()

        pairs = [(one: "Label 1 with some text", two: "Label 1 with some text"),
        (one: "Label 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some text", two: "Label 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some text"),
        (one: "Label 1 with some text", two: "Label 1 with some text"),
        (one: "Label 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some text", two: "Label 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some text"),
        (one: "Label 1 with some text", two: "Label 1 with some text"),
        (one: "Label 1 with some text", two: "Label 1 with some text"),
        (one: "Label 1 with some text", two: "Label 1 with some text"),
        (one: "Label 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some text", two: "Label 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some text"),
        (one: "Label 1 with some text", two: "Label 1 with some text"),
        (one: "Label 1 with some text", two: "Label 1 with some text"),
        (one: "Label 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some text", two: "Label 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some text"),
        (one: "Label 1 with some text", two: "Label 1 with some text"),
        (one: "Label 1 with some text", two: "Label 1 with some text"),
        (one: "Label 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some text", two: "Label 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some text"),
        (one: "Label 1 with some text", two: "Label 1 with some text"),
        (one: "Label 1 with some text", two: "Label 1 with some text"),
        (one: "Label 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some text", two: "Label 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some textLabel 1 with some text"),
        (one: "Label 1 with some text", two: "Label 1 with some text"),
        (one: "Label 1 with some text", two: "Label 1 with some text")]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        Used for self sizing cell
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 1000
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")

        cell = nib.instantiate(withOwner: nil, options: nil).first! as! TableViewCell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pairs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)

        if let tableCell = cell as? TableViewCell {
            let pair = pairs[indexPath.row]
            tableCell.label1.text = pair.one
            tableCell.label2.text = pair.two
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let pair = pairs[indexPath.row]
        cell.label1.text = pair.one
        cell.label2.text = pair.two
        return cell.systemLayoutSizeFitting(CGSize(width: tableView.bounds.width, height: CGFloat.greatestFiniteMagnitude),
                                     withHorizontalFittingPriority: .required,
                                     verticalFittingPriority: .fittingSizeLevel).height
    }

//    Used for self sizing cell
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        let label = UILabel()
//        label.numberOfLines = 0
//        let pair = pairs[indexPath.row]
//        label.text = pair.one
//        label.sizeToFit()
//        return label.bounds.height / 2
//    }
}

