//
//  Store.swift
//  FluxExample
//
//  Created by artembolotov on 06.02.2023.
//

import Foundation
import Combine
import SwiftUI

typealias Reducer<State, Action> = (State, Action) -> State
typealias Middleware<State, Action> = (State, Action) async -> Action?

@MainActor
final class Store<State, Action>: ObservableObject {
    @Published private(set) var state: State

    private let reducer: Reducer<State, Action>
    private let middleware: Middleware<State, Action>

    init (initialState: State, reducer: @escaping Reducer<State, Action>, middleware: @escaping Middleware<State, Action>) {
        self.state = initialState
        self.reducer = reducer
        self.middleware = middleware
    }

    func send(_ action: Action) async {
        state = reducer(self.state, action)

        if let nextAction = await self.middleware(state, action) {
            await send(nextAction)
        }
        
//        await withTaskGroup(of: Optional<Action>.self, body: { [state] taskGroup in
//            
//            taskGroup.addTask { [weak self] in
//                await self?.middleware(state, action)
//            }
//
//            for await case let action? in taskGroup where !Task.isCancelled {
//                await send(action)
//            }
//        })
    }
}
