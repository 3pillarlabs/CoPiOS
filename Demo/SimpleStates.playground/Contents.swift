//: Playground - noun: a place where people can play

import UIKit

class StageOneStateMachine {
    private (set) var isOn: Bool = false

    func changeState() {
        isOn = !isOn
    }
}


let soStateMachine = StageOneStateMachine()
print(soStateMachine.isOn)
soStateMachine.changeState()
print(soStateMachine.isOn)



















class StageTwoStateMachine {
    enum State {
        case noData, loading, data
    }

    private (set) var currentState: State

    init(initialState state: State = .noData) {
        currentState = state
    }

    func changeState() {
        switch currentState {
        case .noData:
            currentState = .loading
        case .loading:
            currentState = .data
        case .data:
            currentState = .noData
        }
    }
}

let stStateMachine = StageTwoStateMachine()
print(stStateMachine.currentState)
stStateMachine.changeState()
print(stStateMachine.currentState)
stStateMachine.changeState()
print(stStateMachine.currentState)
stStateMachine.changeState()
print(stStateMachine.currentState)

