//
//  MasterViewController.swift
//  Operations
//
//  Created by Dorel Macra on 29/08/2017.
//
//

import UIKit

typealias JSONType = [String : Any]

class MasterViewController: UIViewController {
    private var json: JSONType?
    private var navigationOperation: Operation?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        json = nil
    }

    @IBAction func startDidTouchUpInside(_ sender: Any) {
        guard self.navigationOperation == nil else { return }

        let topPaidAppsFeedURL = URL(string: "http://phobos.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/limit=75/json")!

        let navigationOperation = NavigationOperation(viewController: self) { [weak self] in
            guard let strongSelf = self else { return false }
            return strongSelf.json != nil
        }
        navigationOperation.completionBlock = { [weak self] in
            self?.navigationOperation = nil
        }
        OperationQueue.main.addOperation(navigationOperation)
        self.navigationOperation = navigationOperation

        let jsonParseOperation = JSONParseOperation()
        jsonParseOperation.completionBlock = { [weak jsonParseOperation] in
            navigationOperation.changeReadyState(change: { [weak self] in
                self?.json = jsonParseOperation?.json as? JSONType
            })
        }
        let networkRequestOperation = NetworkRequestOperation(url: topPaidAppsFeedURL)
        networkRequestOperation.completionBlock = { [weak networkRequestOperation] in
            if let networkData = networkRequestOperation?.data {
                jsonParseOperation.setData(networkData)
            }
        }

        let operationQueue = OperationQueue()
        let operations = [networkRequestOperation, jsonParseOperation]
        operationQueue.addOperations(operations, waitUntilFinished: false)
    }
    // MARK: Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationController = segue.destination as? DetailViewController {
            destinationController.json = json
        }
    }
}
