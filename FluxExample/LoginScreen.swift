//
//  LoginScreen.swift
//  FluxExample
//
//  Created by artembolotov on 07.02.2023.
//

import SwiftUI

struct LoginScreen: View {
    @EnvironmentObject var store: AppStore
    var body: some View {
        Button("Login") {
            Task { await store.send(.auth(.login)) }
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static let store = AppStore(initialState: .init(auth: .init(), news: .init()), reducer: appReducer, middleware: appMiddleware)
    
    static var previews: some View {
        LoginScreen()
            .environmentObject(store)
    }
}
