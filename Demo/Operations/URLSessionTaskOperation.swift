/*
Copyright (C) 2015 Apple Inc. All Rights Reserved.
See LICENSE.txt for this sample’s licensing information

Abstract:
Shows how to lift operation-like objects in to the NSOperation world.
*/

// Modified
// Source: https://developer.apple.com/sample-code/wwdc/2015/downloads/Advanced-NSOperations.zip

import Foundation

private var URLSessionTaksOperationKVOContext = 0

/**
    `URLSessionTaskOperation` is an `Operation` that lifts an `NSURLSessionTask`
    into an operation.

    Note that this operation does not participate in any of the delegate callbacks \
    of an `NSURLSession`, but instead uses Key-Value-Observing to know when the
    task has been completed. It also does not get notified about any errors that
    occurred during execution of the task.

    An example usage of `URLSessionTaskOperation` can be seen in the `DownloadEarthquakesOperation`.
*/
class URLSessionTaskOperation: Operation {
    let task: URLSessionTask
    
    init(task: URLSessionTask) {
        assert(task.state == .suspended, "Tasks must be suspended.")
        self.task = task
        super.init()
    }

    //MARK: Operation overrides
    override func start() {
        super.start()

        if isCancelled {
            finish()
        }
    }

    override func main() {
        if isCancelled {
            finish()
        } else {
            execute()
        }
    }

    override var isExecuting: Bool {
        return task.state == .running || task.state == .suspended
    }

    override var isFinished: Bool {
        return task.state == .canceling || task.state == .completed
    }

    override func cancel() {
        task.cancel()
        super.cancel()
    }

    override final func waitUntilFinished() {
        fatalError("Avoid Waiting on operations!")
    }

    //MARK: Private methods
    private func execute() {
        task.addObserver(self, forKeyPath: "state", options: [], context: &URLSessionTaksOperationKVOContext)

        willChangeValue(forKey: "isExecuting")
        task.resume()
        didChangeValue(forKey: "isExecuting")
    }

    private func finish() {
        willChangeValue(forKey: "isExecuting")
        willChangeValue(forKey: "isFinished")
        didChangeValue(forKey: "isExecuting")
        didChangeValue(forKey: "isFinished")
    }

    //MARK: Task state KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard context == &URLSessionTaksOperationKVOContext, let object = object as? URLSessionTask else { return }

        if object === task && keyPath == "state" && task.state == .completed {
            task.removeObserver(self, forKeyPath: "state")
            finish()
        }
    }
}
