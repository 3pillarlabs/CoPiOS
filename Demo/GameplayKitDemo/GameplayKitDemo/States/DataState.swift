//
//  DataState.swift
//  GameplayKitDemo
//
//  Created by David Livadaru on 16/11/2017.
//  Copyright © 2017 3Pillar Global. All rights reserved.
//

import GameplayKit

class DataState: State {
    override var validStates: [State.Type] {
        return [LoadingState.self, NoDataState.self]
    }
}
