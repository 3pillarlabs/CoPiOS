//
//  ContainerViewController.swift
//  BasicMVC
//
//  Created by David Livadaru on 05/03/2018.
//  Copyright © 2018 David Livadaru. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController, ListViewControllerDelegate, ModelContainerObserver {
    @IBOutlet private weak var plusBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var containerView: UIView!
    private let model = ModelContainer()
    private var listViewController: ListViewController?

    private lazy var noDataViewController = NoDataViewController()
    private lazy var loadingViewController = LoadingViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        model.observer = self
        addChildListViewController()
        presentChild(noDataViewController, animated: false)
    }

    // MARK: ListViewControllerDelegate

    func listViewController(_ listViewController: ListViewController, shouldAddItemAt index: Int) {
        model.insert(Date(), at: index)
    }

    func listViewController(_ listViewController: ListViewController, shouldRemoveItemAt index: Int) {
        model.remove(at: index)
    }

    func listViewController(_ listViewController: ListViewController, shouldDisplayDetailForItemAt index: Int) {
        guard let date = model.objects[index] as? Date else { return }

        let detailViewController = DetailViewController(date: date)
        navigationController?.pushViewController(detailViewController, animated: true)
    }

    // MARK: ModelContainerObserver

    func modelContainer(_ modelContainer: ModelContainer, willChangeCountFrom old: Int, to new: Int, index: Int,
                        action: ModelAction) {
        presentChild(loadingViewController, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                self.dismissChild(self.loadingViewController, completion: {
                    self.updateNoDataChild(for: new, completion: {
                        self.updateListViewController(for: index, action: action)
                    })
                })
            })
        })
    }

    // MARK: Private actions

    @IBAction func plusBarButtonDidTouchUpinside(_ sender: Any) {
        model.addObject(Date())
    }

    // MARK: Private functionality

    private func addChildListViewController() {
        let listViewController = ListViewController(model: model)
        listViewController.delegate = self
        addChildViewController(listViewController)
        let listView: UIView! = listViewController.view
        listView.frame = containerView.bounds
        listView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.addSubview(listView)
        listViewController.didMove(toParentViewController: self)
        self.listViewController = listViewController
    }

    private func updateNoDataChild(for newCount: Int, completion: @escaping () -> Void) {
        switch newCount {
        case 0:
            self.presentChild(self.noDataViewController, completion: completion)
        case 1:
            self.dismissChild(self.noDataViewController, completion: completion)
        default:
            completion()
            break
        }
    }

    private func updateListViewController(for index: Int, action: ModelAction) {
        switch action {
        case .insert:
            listViewController?.updateAdditionOfItem(at: index)
        case .delete:
            listViewController?.updateRemovalOfItem(at: index)
        }
    }

    private func presentChild(_ child: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        addChildViewController(child)
        let childView: UIView! = child.view
        childView.frame = view.bounds
        childView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childView.alpha = 0.0
        view.addSubview(childView)
        UIView.animate(withDuration: animated ? 0.3 : 0.0, animations: {
            childView.alpha = 1.0
        }) { _ in
            child.didMove(toParentViewController: self)
            completion?()
        }
    }

    private func dismissChild(_ child: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        child.willMove(toParentViewController: nil)
        let childView: UIView! = child.view
        UIView.animate(withDuration: animated ? 0.3 : 0.0, animations: {
            childView.alpha = 0.0
        }) { _ in
            childView.removeFromSuperview()
            child.removeFromParentViewController()
            completion?()
        }
    }
}
