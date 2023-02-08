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
    var news: NewsState
}

enum AppAction {
    case auth(_ action: AuthAction)
    case news(_ action: NewsAction)
}

func appReducer(state: inout AppState, action: AppAction) -> AnyPublisher<AppAction, Never> {
    switch action {
    case let .auth(action: action):
        return authReducer(state: &state.auth, action: action)
            .map(AppAction.auth)
            .eraseToAnyPublisher()
    case let .news(action: action):
        return newsReducer(state: &state.news, action: action)
            .map(AppAction.news)
            .eraseToAnyPublisher()
    }
    //return Empty().eraseToAnyPublisher()
}

typealias AppStore = Store<AppState, AppAction>
