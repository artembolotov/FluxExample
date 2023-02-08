//
//  Auth.swift
//  FluxExample
//
//  Created by artembolotov on 06.02.2023.
//

import Foundation
import Combine

struct AuthState {
    var state: AuthState.State = .unknown
    
    enum State {
        case authentificated, notAuthentificated, unknown
    }
}

enum AuthAction {
    case login, logout, check
}

func authReducer(state: inout AuthState, action: AuthAction) -> AnyPublisher<AuthAction, Never> {
    @Injected var authService: AuthServiceProtocol
    
    switch action {
    case .check:
        let isAuthentificated = authService.checkAuth()
        state.state = isAuthentificated ? .authentificated : .notAuthentificated
    case .login:
        authService.login()
        state.state = .authentificated
    case .logout:
        authService.logout()
        state.state = .notAuthentificated
    }
    return Empty().eraseToAnyPublisher()
}
