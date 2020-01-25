//
//  TableViewController.swift
//  SelfSizingTableViewCells
//
//  Created by David Livadaru on 24/01/2020.
//  Copyright © 2020 3Pillar Global. All rights reserved.
//

import UIKit
import Nuke

class TableViewController: UITableViewController {
    private let dataSource = DataSource()
    private var placeholder: UIImage! { UIImage(named: "placeholder")! }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)

        if let customCell = cell as? TableViewCell {
            let forest = dataSource.objects[indexPath.row]
            let options = ImageLoadingOptions(
                placeholder: placeholder, transition: ImageLoadingOptions.Transition.fadeIn(duration: 0.3)
            )
            Nuke.loadImage(with: forest.imageURL, options: options, into: customCell.cellImageView)
            customCell.titleLabel.text = forest.title
            customCell.descriptionLabel.text = forest.description
        }

        return cell
    }
}
