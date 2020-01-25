//
//  TableViewCell.swift
//  SelfSizingTableViewCells
//
//  Created by David Livadaru on 24/01/2020.
//  Copyright © 2020 3Pillar Global. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {    
    @IBOutlet private(set) weak var cellImageView: UIImageView!
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var descriptionLabel: UILabel!
}
