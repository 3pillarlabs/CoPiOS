//
//  ViewController.swift
//  ExampleSyncAnimation
//
//  Created by David Livadaru on 17/08/2017.
//  Copyright © 2017 3Pillar Global. All rights reserved.
//

import UIKit

protocol ActionDelegate: class {
    func didTapButton(viewController: UIViewController)
}

class ViewController: UIViewController, ActionDelegate {
    private var child1: ViewController1!
    private var child2: ViewController2!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        child1 = ViewController1(nibName: "ViewController1", bundle: nil)
        child1.delegate = self
        child2 = ViewController2(nibName: "ViewController2", bundle: nil)
        child2.delegate = self

        addChild(viewController: child1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: ActionDelegate

    func didTapButton(viewController: UIViewController) {
        if viewController === child1 {
            // present child 2
            self.addChild(viewController: self.child2)
            let presentAnimation2 = PresentSecondChild2(viewController: child2, traits: AnimationTraits(duration: 1.0))
            presentAnimation2.performAnimation()
            let presentAnimation = PresentSecondChild(viewController: child2, traits: AnimationTraits(duration: 10.0))
            presentAnimation2.add(completion: { _ in
                presentAnimation.performAnimation()
            })
        } else {
            // present child 1
        }
    }
}

extension UIViewController {
    func addChild(viewController: UIViewController, within subview: UIView? = nil) {
        let container: UIView = subview ?? view
        addChildViewController(viewController)
        viewController.view.frame = container.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        container.addSubview(viewController.view)
        viewController.didMove(toParentViewController: self)
    }
}

final class PresentSecondChild: Animation {
    private var viewController: ViewController2

    init(viewController: ViewController2, traits: AnimationTraits, changesNonAnimatableProperties: Bool = true) {
        self.viewController = viewController
        super.init(traits: traits, changesNonAnimatableProperties: changesNonAnimatableProperties)

        addAnimations()
    }

    private func addAnimations() {
        let fadeIn = FadeAnimation(view: viewController.label, kind: .inside)
        add(preparation: {[weak self] in

            self?.viewController.verticalCenter.constant = -100.0
        })
        add(animationClosure: { [weak self] in
            self?.viewController.view.layoutIfNeeded()
        })

        add(animationTick: { [weak self] in
            self?.changeLineHeight()
        })

        synchronize(animation: fadeIn)
    }

    private func changeLineHeight() {
        guard let label = viewController.label else { return }
        if let presentationLayer = label.layer.presentation() {
            let lineSpacing = 50 * (1 - presentationLayer.opacity)
            print(lineSpacing)
            var attributes: [NSAttributedStringKey: Any] = [:]
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = CGFloat(lineSpacing)
            attributes[.paragraphStyle] = paragraphStyle
            let attributedText = NSAttributedString(string: label.text!, attributes: attributes)
            label.attributedText = attributedText
        }
    }
}

final class PresentSecondChild2: Animation {
    private var viewController: ViewController2

    init(viewController: ViewController2, traits: AnimationTraits, changesNonAnimatableProperties: Bool = true) {
        self.viewController = viewController
        super.init(traits: traits, changesNonAnimatableProperties: changesNonAnimatableProperties)

        addAnimations()
    }

    private func addAnimations() {
        let fadeOut = FadeAnimation(view: viewController.label, kind: .outside)

        add(preparation: {[weak self] in
            fadeOut.performChangesWithoutAnimation()

            var frame = UIScreen.main.bounds
            frame.origin.x = frame.width
            self?.viewController.view.frame = frame
        })
        add(animationClosure: { [weak self] in
            self?.viewController.view.frame = UIScreen.main.bounds
        })
    }
}


final class FadeAnimation: Animation {
    enum Kind {
        case inside, outside
    }

    let view: UIView
    let kind: Kind

    init(view: UIView, kind: Kind, traits: AnimationTraits = AnimationTraits(),
         changesNonAnimatableProperties: Bool = false) {
        self.view = view
        self.kind = kind

        super.init(traits: traits, changesNonAnimatableProperties: changesNonAnimatableProperties)

        addAnimations()
    }

    private func addAnimations() {
        add(animationClosure: { [weak self] in
            guard let strongSelf = self else { return }

            switch strongSelf.kind {
            case .inside:
                strongSelf.view.alpha = 1.0
            case .outside:
                strongSelf.view.alpha = 0.0
            }
        })
    }
}

