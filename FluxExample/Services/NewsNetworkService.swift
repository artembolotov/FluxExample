//
//  NewsNetworkService.swift
//  FluxExample
//
//  Created by artembolotov on 08.02.2023.
//

import Foundation
import ApiManager

protocol NewsNetworkServiceProtocol {
    func articlesGet(limit: Int, start: Int, completion: @escaping ([Article]?) -> Void)
}

final class NewsNetworkService: NewsNetworkServiceProtocol {

    @Injected private var apiManager: ApiManagerProtocol
    
    private let url = "https://api.spaceflightnewsapi.net/v3"
    
    func articlesGet(limit: Int, start: Int, completion: @escaping ([Article]?) -> Void) {
        let fullUrl = url + "/articles"
        let parameters = [
            "_limit": "\(limit)",
            "_start": "\(start)"
        ]
        apiManager.fetch(url: fullUrl, parameters: parameters, handler: completion)
    }
}
