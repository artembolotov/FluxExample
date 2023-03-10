//
//  WelcomeView.swift
//  FluxExample
//
//  Created by artembolotov on 06.02.2023.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var store: AppStore
    var body: some View {
        Group {
            switch store.state.auth.state {
            case .authentificated:
                NewsScreen()
            case .notAuthentificated:
                LoginScreen()
            case .unknown:
                ProgressView()
            }
        }
        .onAppear {
            Task { await store.send(.auth(.check)) }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static let store = AppStore(initialState: .init(auth: .init(), news: .init()), reducer: appReducer, middleware: appMiddleware)
    static var previews: some View {
        WelcomeView()
            .environmentObject(store)
    }
}
