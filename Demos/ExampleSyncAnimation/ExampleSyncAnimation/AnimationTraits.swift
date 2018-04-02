//
//  AnimationTraits.swift
//  iambank
//
//  Created by David Livadaru on 17/08/2017.
//  Copyright © 2017 3Pillar Global. All rights reserved.
//

import UIKit

struct AnimationTraits {
    let duration: TimeInterval
    let delay: TimeInterval
    let options: UIViewAnimationOptions

    struct Spring {
        let damping: CGFloat
        let velocity: CGFloat
    }

    let spring: Spring?

    init(duration: TimeInterval = 0.0, delay: TimeInterval = 0.0, options: UIViewAnimationOptions = [],
         spring: Spring? = nil) {
        self.duration = duration
        self.delay = delay
        self.options = options
        self.spring = spring
    }
}
