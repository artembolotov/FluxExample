//
//  FluxExampleApp.swift
//  FluxExample
//
//  Created by artembolotov on 06.02.2023.
//

import SwiftUI

@main
struct FluxExampleApp: App {
    let store = AppStore(initialState: .init(auth: .init()), reducer: appReducer)
    
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
