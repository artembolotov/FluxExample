//
//  NewsNetworkService.swift
//  FluxExample
//
//  Created by artembolotov on 08.02.2023.
//

import Foundation
import ApiManager

protocol NewsNetworkServiceProtocol {
    func articlesGet(source: NewsSite, limit: Int, start: Int) async -> [Article]
}

final class NewsNetworkService: NewsNetworkServiceProtocol {

    @Injected private var apiManager: ApiManagerProtocol
    
    private let url = "https://api.spaceflightnewsapi.net/v3"
    
    func articlesGet(source: NewsSite, limit: Int, start: Int) async -> [Article] {
        let fullUrl = url + "/articles"
        let parameters = [
            "_limit": "\(limit)",
            "_start": "\(start)",
            "newsSite": "\(source.rawValue)"
        ]
        
        return await withCheckedContinuation({ continuation in
            let handler: ([Article]?) -> Void = { articles in
                continuation.resume(returning: articles ?? [])
            }
             
            apiManager.fetch(url: fullUrl, parameters: parameters, handler: handler)
        })
    }
}
