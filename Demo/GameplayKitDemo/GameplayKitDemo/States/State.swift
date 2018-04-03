//
//  State.swift
//  GameplayKitDemo
//
//  Created by David Livadaru on 16/11/2017.
//  Copyright © 2017 3Pillar Global. All rights reserved.
//

import GameplayKit

class State: GKState {
    var validStates: [State.Type] {
        return []
    }

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if validStates.first(where: { stateClass == $0 }) == nil {
            assert(false, "Attempt to enter invalid state: \(stateClass)")
            return false
        } else {
            return true
        }
    }

    override func willExit(to nextState: GKState) {
        print("Will exit from \(type(of: self)) to \(type(of: nextState))")
    }

    override func didEnter(from previousState: GKState?) {
        if let previousState = previousState {
            print("Did enter \(type(of: self)) from \(type(of: previousState)).")
        } else {
            print("Did enter \(type(of: self)).")
        }
    }
}
