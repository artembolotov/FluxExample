//
//  App.swift
//  FluxExample
//
//  Created by artembolotov on 06.02.2023.
//

import Foundation
import Combine

struct AppState {
    var auth: AuthState
}

enum AppAction {
    case auth(_ action: AuthAction)
}

func appReducer(state: inout AppState, action: AppAction) -> AnyPublisher<AppAction, Never> {
    switch action {
    case let .auth(action: action):
        return authReducer(state: &state.auth, action: action)
            .map(AppAction.auth)
            .eraseToAnyPublisher()
    }
    //return Empty().eraseToAnyPublisher()
}

typealias AppStore = Store<AppState, AppAction>
