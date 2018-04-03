//
//  NoDataState.swift
//  GameplayKitDemo
//
//  Created by David Livadaru on 16/11/2017.
//  Copyright © 2017 3Pillar Global. All rights reserved.
//

import GameplayKit

protocol NoDataViewPresenter: class {
    var noDataView: UIView! { get }
}

class NoDataState: State {
    private (set) weak var presenter: NoDataViewPresenter?

    init(presenter: NoDataViewPresenter) {
        self.presenter = presenter
    }

    override var validStates: [State.Type] {
        return [LoadingState.self]
    }

    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)

        presenter?.noDataView.alpha = 1.0
    }

    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)

        presenter?.noDataView.alpha = 0.0
    }
}
