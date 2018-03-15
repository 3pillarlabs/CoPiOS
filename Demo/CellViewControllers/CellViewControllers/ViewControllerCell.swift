//
//  ViewControllerCell.swift
//  CellViewControllers
//
//  Created by David Livadaru on 11/25/17.
//  Copyright © 2017 David Livadaru. All rights reserved.
//

import UIKit

class ViewControllerCell: UITableViewCell {
    var viewController: UIViewController?

    static var identifier: String {
        return String(describing: self)
    }
}
