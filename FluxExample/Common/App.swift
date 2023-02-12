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

func appReducer(state: AppState, action: AppAction) -> AppState {
    var state = state
    switch action {
    case let .auth(action: action):
        state.auth = authReducer(state: state.auth, action: action)
        
        if action == .logout {
            state.news = .init()
        }
    case let .news(action: action):
        state.news = newsReducer(state: state.news, action: action)
    }
    return state
}

let appMiddleware: Middleware<AppState, AppAction> = { state, action in
    switch action {
    case .news(let action):
        if let newsAction = await newsMiddleware(state.news, action) {
            return AppAction.news(newsAction)
        }
    default:
        return nil
    }
    
    return nil
}

typealias AppStore = Store<AppState, AppAction>
