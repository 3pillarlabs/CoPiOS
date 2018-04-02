//
//  TableViewCell.swift
//  SelfSizingCells
//
//  Created by David Livadaru on 20/07/2017.
//  Copyright © 2017 3Pillar Global. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
