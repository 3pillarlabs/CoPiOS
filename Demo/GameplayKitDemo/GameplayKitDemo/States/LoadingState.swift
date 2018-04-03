//
//  LoadingState.swift
//  GameplayKitDemo
//
//  Created by David Livadaru on 16/11/2017.
//  Copyright © 2017 3Pillar Global. All rights reserved.
//

import GameplayKit

protocol LoadingViewPresenter: class {
    var loadingView: LoadingView! { get }
    var addBarItem: UIBarButtonItem? { get }
}

class LoadingState: State {
    private (set) weak var presenter: LoadingViewPresenter?

    init(presenter: LoadingViewPresenter) {
        self.presenter = presenter
    }
    
    override var validStates: [State.Type] {
        return [NoDataState.self, DataState.self]
    }

    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)

        presenter?.loadingView.alpha = 1.0
        presenter?.loadingView.startLoading()
        presenter?.addBarItem?.isEnabled = false
    }

    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)

        presenter?.loadingView.alpha = 0.0
        presenter?.loadingView.stopLoading()
        presenter?.addBarItem?.isEnabled = true
    }
}
