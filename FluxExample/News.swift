//
//  News.swift
//  FluxExample
//
//  Created by artembolotov on 08.02.2023.
//

import Foundation
import Combine
import SwiftUI

let fetchLimit = 40

struct NewsState {
    let sources: [NewsSite] = [.spaceNews, .arstechnica, .cnbс, .nasa]
    
    var currentSource: NewsSite
    
    var articles: [NewsSite: [Article]]
    var lastIds = [NewsSite: Int]()
    var fetchOffsets: [NewsSite: Int]
    
    var isFetching: [NewsSite: Bool]
    var canFetchMore: [NewsSite: Bool]
    
    
    init() {
        currentSource = sources.first!
        
        articles = Dictionary(uniqueKeysWithValues: sources.map { ($0, []) })
        
        isFetching = Dictionary(uniqueKeysWithValues: sources.map { ($0, false) })
        canFetchMore = Dictionary(uniqueKeysWithValues: sources.map { ($0, true) })
        fetchOffsets = Dictionary(uniqueKeysWithValues: sources.map { ($0, 0) })
    }
    
}

enum NewsAction {
    case fetchCurrent
    case setSource(newsSite: NewsSite)
    case appendArticlesForSource(source: NewsSite, articles: [Article])
}

func newsReducer(state: NewsState, action: NewsAction) -> NewsState {
    var state = state
    @Injected var newsService: NewsNetworkServiceProtocol
    
    switch action {
    case .fetchCurrent:
        let source = state.currentSource
        state.isFetching[source] = true
        
    case .setSource(newsSite: let source):
        state.currentSource = source
        
    case .appendArticlesForSource(let source, articles: let articles):
        state.isFetching[source] = false
        let count = articles.count
        state.articles[source]!.append(contentsOf: articles)
        state.fetchOffsets[source]! += count
        state.lastIds[source] = articles.suffix(min(fetchLimit, 4)).map { $0.id }.first
    }
    
    return state    
}

let newsMiddleware: Middleware<NewsState, NewsAction> = { state, action in
    @Injected var newsNetworkService: NewsNetworkServiceProtocol
    
    switch action {
    case .fetchCurrent:
        let source = state.currentSource
      
        let start = state.fetchOffsets[source]!
        
        let articles = await newsNetworkService.articlesGet(source: source, limit: fetchLimit, start: start)
        return .appendArticlesForSource(source: source, articles: articles)
    case .setSource(newsSite: let source):
        let fetchOffset = state.fetchOffsets[source]!
        return fetchOffset > 0 ? nil : .fetchCurrent

    default:
        return nil
    }
}
