//
//  NewsScreen.swift
//  FluxExample
//
//  Created by artembolotov on 08.02.2023.
//

import SwiftUI

struct NewsScreen: View {
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        NavigationView {
            Text("Authentificated")
                .navigationTitle("News")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Logout", action: logout)
                    }
                }
        }
    }
    
    func logout() {
        withAnimation {
            store.send(.auth(.logout))
        }
    }
}

struct NewsScreen_Previews: PreviewProvider {
    static let store = AppStore(initialState: .init(auth: .init()), reducer: appReducer)
    
    static var previews: some View {
        NewsScreen()
            .environmentObject(store)
    }
}
