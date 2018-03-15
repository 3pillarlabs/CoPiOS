//
//  ListViewController.swift
//  BasicMVC
//
//  Created by David Livadaru on 05/03/2018.
//  Copyright © 2018 David Livadaru. All rights reserved.
//

import UIKit

protocol ListViewControllerDelegate: class {
    func listViewController(_ listViewController: ListViewController, shouldAddItemAt index: Int)
    func listViewController(_ listViewController: ListViewController, shouldRemoveItemAt index: Int)
    func listViewController(_ listViewController: ListViewController, shouldDisplayDetailForItemAt index: Int)
}

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    weak var delegate: ListViewControllerDelegate?

    @IBOutlet private weak var tableView: UITableView!
    private let model: ModelContainer

    init(model: ModelContainer) {
        self.model = model

        super.init(nibName: "ListViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Decoding from storyboard is not supported.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    func updateAdditionOfItem(at index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        tableView.insertRows(at: [indexPath], with: .fade)
    }

    func updateRemovalOfItem(at index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }

    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.objects.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        if let date = model.objects[indexPath.row] as? NSDate {
            cell.textLabel?.text = date.description
        }

        return cell
    }

    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delegate?.listViewController(self, shouldRemoveItemAt: indexPath.row)
        } else if editingStyle == .insert {
            delegate?.listViewController(self, shouldAddItemAt: indexPath.row)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.listViewController(self, shouldDisplayDetailForItemAt: indexPath.row)
    }
}
