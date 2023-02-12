//
//  FluxExampleApp.swift
//  FluxExample
//
//  Created by artembolotov on 06.02.2023.
//

import SwiftUI

@main
struct FluxExampleApp: App {
    @StateObject var store = AppStore(
        initialState: AppState(auth: AuthState(), news: NewsState()),
        reducer: appReducer,
        middleware: appMiddleware
    )
    
    init() {
        Configurator.shared.setup()
    }
    
    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .environmentObject(store)
        }
    }
}
