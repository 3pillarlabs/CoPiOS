//
//  MasterViewController.swift
//  GameplayKitDemo
//
//  Created by David Livadaru on 16/11/2017.
//  Copyright © 2017 3Pillar Global. All rights reserved.
//

import UIKit
import GameplayKit

class MasterViewController: UITableViewController, LoadingViewPresenter, NoDataViewPresenter {

    var detailViewController: DetailViewController? = nil
    var objects = [Any]()

    private (set) var noDataView: UIView!
    private (set) var loadingView: LoadingView!

    var addBarItem: UIBarButtonItem? {
        return navigationItem.rightBarButtonItem
    }

    private var stateMachine: GKStateMachine!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        addCustomSubviews()

        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }

        setupStateMachine()
        updateState()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc
    func insertNewObject(_ sender: Any) {
        UIView.animate(withDuration: 0.25, animations: {
            self.stateMachine.enter(LoadingState.self)
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                self.objects.insert(NSDate(), at: 0)
                let indexPath = IndexPath(row: 0, section: 0)
                self.tableView.insertRows(at: [indexPath], with: .automatic)
                UIView.animate(withDuration: 0.25, animations: {
                    self.updateState()
                })
            })
        }
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! NSDate
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let object = objects[indexPath.row] as! NSDate
        cell.textLabel!.text = object.description
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }

        updateState()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    private func addCustomSubviews() {
        view.translatesAutoresizingMaskIntoConstraints = false
        noDataView = UIView(frame: view.bounds)
        noDataView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noDataView)
        noDataView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        noDataView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        noDataView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        noDataView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        let label = UILabel(frame: noDataView.bounds)
        label.translatesAutoresizingMaskIntoConstraints = true
        label.text = "No data is available."
        label.sizeToFit()
        noDataView.addSubview(label)
        label.centerXAnchor.constraint(equalTo: noDataView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: noDataView.centerYAnchor).isActive = true
        noDataView.alpha = 0.0

        loadingView = LoadingView(frame: view.bounds)
        loadingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(loadingView)
        loadingView.alpha = 0.0
    }

    private func setupStateMachine() {
        let noDataState = NoDataState(presenter: self)
        let loadingState = LoadingState(presenter: self)
        let dataState = DataState()
        stateMachine = GKStateMachine(states: [noDataState, loadingState, dataState])
    }

    private func updateState() {
        if objects.count == 0 {
            stateMachine.enter(NoDataState.self)
        } else {
            stateMachine.enter(DataState.self)
        }
    }
}

