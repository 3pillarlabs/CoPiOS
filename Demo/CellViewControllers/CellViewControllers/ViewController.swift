//
//  ViewController.swift
//  CellViewControllers
//
//  Created by David Livadaru on 11/23/17.
//  Copyright © 2017 David Livadaru. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    private var colors: [UIColor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let nib = UINib(nibName: ViewControllerCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ViewControllerCell.identifier)
    }

    // MARK: UITableViewDataSource

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewControllerCell.identifier, for: indexPath)
        if let viewControllerCell = cell as? ViewControllerCell {
            if viewControllerCell.viewController == nil {
                viewControllerCell.viewController = UIViewController()

            }

            let viewController = viewControllerCell.viewController
            switch indexPath.row % 3 {
            case 0:
                viewController?.view.backgroundColor = UIColor.red
            case 1:
                viewController?.view.backgroundColor = UIColor.blue
            default:
                viewController?.view.backgroundColor = UIColor.purple
            }
        }
        return cell
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? ViewControllerCell else { return }
        guard let viewController = cell.viewController else { return }

        addChildViewController(viewController)
        let view: UIView = viewController.view
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = cell.contentView.bounds
        cell.contentView.addSubview(view)
        viewController.didMove(toParentViewController: self)
    }

    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell,
                          forRowAt indexPath: IndexPath) {
        guard let cell = cell as? ViewControllerCell else { return }
        guard let viewController = cell.viewController else { return }

        viewController.willMove(toParentViewController: nil)
        let view = viewController.view
        view?.removeFromSuperview()
        viewController.removeFromParentViewController()
        viewController.didMove(toParentViewController: nil)
    }
}
