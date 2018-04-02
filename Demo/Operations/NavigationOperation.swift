//
//  NavigationOperation.swift
//  Operations
//
//  Created by David Livadaru on 05/09/2017.
//
//

import UIKit

class NavigationOperation: Operation {
    typealias ObserveClosure = () -> Void
    typealias ReadyClosure = () -> Bool

    private let viewController: UIViewController

    private let readyClosure: ReadyClosure

    override var isReady: Bool {
        return super.isReady && readyClosure()
    }

    init(viewController: UIViewController, readyClosure: @escaping ReadyClosure) {
        self.viewController = viewController
        self.readyClosure = readyClosure
    }

    func changeReadyState(change: ObserveClosure) {
        willChangeValue(forKey: "isReady")
        change()
        didChangeValue(forKey: "isReady")
    }

    override func main() {
        viewController.performSegue(withIdentifier: "showDetailViewSegue", sender: self)
    }
}
