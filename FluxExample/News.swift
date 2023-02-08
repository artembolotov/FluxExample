//
//  News.swift
//  FluxExample
//
//  Created by artembolotov on 08.02.2023.
//

import Foundation
import Combine

struct NewsState {
    
}

enum NewsAction {
    case fetch
}

func newsReducer(state: inout NewsState, action: NewsAction) -> AnyPublisher<NewsAction, Never> {
//    @Injected var authService: AuthServiceProtocol
//    
//    switch action {
//    case .check:
//        let isAuthentificated = authService.checkAuth()
//        state.state = isAuthentificated ? .authentificated : .notAuthentificated
//    case .login:
//        authService.login()
//        state.state = .authentificated
//    case .logout:
//        authService.logout()
//        state.state = .notAuthentificated
//    }
    return Empty().eraseToAnyPublisher()
}
