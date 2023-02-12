//
//  NewsScreen.swift
//  FluxExample
//
//  Created by artembolotov on 08.02.2023.
//

import SwiftUI

struct NewsScreen: View {
    @EnvironmentObject var store: AppStore
    @State private var selected: NewsSite = .arstechnica
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Select news source", selection: $selected) {
                    ForEach(store.state.news.sources, id: \.self) {
                        Text($0.name)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        let source = store.state.news.currentSource
                        let articles = store.state.news.articles[source]!
                        
                        ForEach(articles) { article in
                            ArticleCell(article: article)
                            .onAppear {
                                let isFetching = store.state.news.isFetching[source]!
                                guard !isFetching else { return }
                                
                                if let lastId = store.state.news.lastIds[source], lastId == article.id {
                                    Task { await store.send(.news(.fetchCurrent)) }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
//                List {
//                    if let source = store.state.news.currentSource {
//                        let articles = store.state.news.articles[source] ?? []
//
//                        ForEach(articles) { article in
//                            ArticleCell(article: article)
//                            .onAppear {
//                                let isFetching = store.state.news.isFetching[source]!
//                                guard !isFetching else { return }
//
//                                if let lastId = store.state.news.lastIds[source], lastId == article.id {
//                                    Task { await store.send(.news(.fetchCurrent)) }
//                                }
//                            }
//                        }
//                    }
//                }
//                .listStyle(.plain)
            }
            .navigationTitle("News")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Logout", action: logout)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    ProgressView()
                        .isHidden(!store.state.news.isFetching[store.state.news.currentSource]!)
                }
            }
        }
        .onChange(of: selected) { newValue in
            Task { await store.send(.news(.setSource(newsSite: newValue))) }
        }
        .onAppear {
            selected = store.state.news.sources.first!
        }
    }
    
    func logout() {
        Task { await store.send(.auth(.logout)) }
    }
}

struct NewsScreen_Previews: PreviewProvider {
    static let store = AppStore(initialState: .init(auth: .init(), news: .init()), reducer: appReducer, middleware: appMiddleware)
    
    static var previews: some View {
        NewsScreen()
            .environmentObject(store)
    }
}
