//
//  NetworkRequestOperation.swift
//  Operations
//
//  Created by Dorel Macra on 29/08/2017.
//
//

import UIKit

class NetworkRequestOperation: Operation {
    let url: URL?

    var data: Data?
    var error: Error?

    private var hasFinished = false
    private let operationQueue = OperationQueue()

    init(url: URL) {
        self.url = url

        super.init()
    }

    override func main() {
        if let taskOperation = createURLOperation() {
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
            operationQueue.addOperation(taskOperation)
        } else {
            finish()
        }
    }

    override var isFinished: Bool {
        return hasFinished
    }

    func finish() {
        willChangeValue(forKey: "isExecuting")
        willChangeValue(forKey: "isFinished")

        hasFinished = true

        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }

        didChangeValue(forKey: "isExecuting")
        didChangeValue(forKey: "isFinished")
    }

    override func cancel() {
        operationQueue.cancelAllOperations()
    }

    private func createURLOperation() -> Operation? {
        guard let url = self.url else { return nil }
        let urlSessionDataTask = URLSession.shared.dataTask(with: url) {[weak self] (data, urlResponse, error) in
            self?.data = data
            self?.error = error
            self?.finish()
        }
        return URLSessionTaskOperation(task: urlSessionDataTask)
    }
}
