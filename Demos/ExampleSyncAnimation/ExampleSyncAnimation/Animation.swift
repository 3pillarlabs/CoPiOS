//
//  Animation.swift
//  iambank
//
//  Created by David Livadaru on 17/08/2017.
//  Copyright © 2017 3Pillar Global. All rights reserved.
//

import UIKit

class Animation {
    typealias Preparation = () -> Void
    typealias Closure = () -> Void
    typealias AnimationTick = () -> Void
    typealias Completion = (Bool) -> Void

    private (set) var changesNonAnimatableProperties: Bool

    let traits: AnimationTraits
    private var preparationPhases: [Preparation] = []
    private var inProgressPhases: [Closure] = []
    private var animationTickPhases: [AnimationTick] = []
    private var completionPhases: [Completion] = []

    private var synchronizedAnimations: [Animation] = []

    init(traits: AnimationTraits, changesNonAnimatableProperties: Bool = false) {
        self.changesNonAnimatableProperties = changesNonAnimatableProperties
        self.traits = traits
    }

    func add(preparation: @escaping Preparation) {
        preparationPhases.append(preparation)
    }

    func add(animationClosure closure: @escaping Closure) {
        inProgressPhases.append(closure)
    }

    func add(animationTick: @escaping AnimationTick) {
        animationTickPhases.append(animationTick)
    }

    func add(completion: @escaping Completion) {
        completionPhases.append(completion)
    }

    func synchronize(animation: Animation) {
        synchronizedAnimations.append(animation)
    }

    func performChangesWithoutAnimation() {
        UIView.performWithoutAnimation {
            self.performChanges()
        }
    }

    func performChanges() {
        prepareAnimation()
        animationInProgress()
        finishAnimation(true)
    }

    /// Start animation. Needs to be called on main queue.
    func performAnimation() {
        prepareAnimation()

        var gpuTimer: CADisplayLink?

        if changesNonAnimatableProperties {
            gpuTimer = CADisplayLink(target: self, selector: #selector(interactiveAnimationTick))
            gpuTimer?.add(to: .current, forMode: .defaultRunLoopMode)
        }

        perform(animation: {
            self.animationInProgress()
        }, withCompletion: { finished in
            gpuTimer?.invalidate()
            self.finishAnimation(finished)
        })
    }

    // MARK: Private functionality

    private func performSync(with animation: Animation) {
        preparationPhases.append(contentsOf: animation.preparationPhases)
        inProgressPhases.append(contentsOf: animation.inProgressPhases)
        animationTickPhases.append(contentsOf: animation.animationTickPhases)
        completionPhases.append(contentsOf: animation.completionPhases)

        if animation.changesNonAnimatableProperties && !changesNonAnimatableProperties {
            changesNonAnimatableProperties = true
        }
    }

    private func syncAnimations() {
        for animation in synchronizedAnimations {
            animation.syncAnimations()
            performSync(with: animation)
        }
    }

    private func prepareAnimation() {
        syncAnimations()

        preparationPhases.forEach { phase in
            phase()
        }
    }

    private func animationInProgress() {
        inProgressPhases.forEach { phase in
            phase()
        }
    }

    @objc private func interactiveAnimationTick() {
        animationTickPhases.forEach { phase in
            phase()
        }
    }

    private func finishAnimation(_ finished: Bool) {
        completionPhases.forEach { phase in
            phase(finished)
        }

        synchronizedAnimations.removeAll()
    }

    private func perform(animation: @escaping Closure, withCompletion completion: @escaping Completion) {
        if let spring = traits.spring {
            UIView.animate(withDuration: traits.duration, delay: traits.delay, usingSpringWithDamping: spring.damping,
                           initialSpringVelocity: spring.velocity, options: traits.options, animations: animation,
                           completion: completion)
        } else {
            UIView.animate(withDuration: traits.duration, delay: traits.delay, options: traits.options,
                           animations: animation, completion: completion)
        }
    }
}
