//
//  Store.swift
//  FluxExample
//
//  Created by artembolotov on 06.02.2023.
//

import Foundation
import Combine

typealias Reducer<State, Action> = (inout State, Action) -> AnyPublisher<Action, Never>?

final class Store<State, Action>: ObservableObject {
    @Published private(set) var state: State
    
    private let reducer: Reducer<State, Action>
    private var effectCancellables: Set<AnyCancellable> = []
    
    init (initialState: State, reducer: @escaping Reducer<State, Action>) {
        self.state = initialState
        self.reducer = reducer
    }
    
    func send(_ action: Action) {
        guard let effect = reducer(&state, action) else { return }
        
        effect
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: send)
            .store(in: &effectCancellables)
    }
    
}
