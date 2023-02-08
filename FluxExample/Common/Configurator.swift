//
//  Configurator.swift
//  FluxExample
//
//  Created by artembolotov on 08.02.2023.
//

import Foundation

final class Configurator {
    static let shared = Configurator()
    
    private init() {}
    
    func setup() {
        setupAuthService()
//        setupApiManager()
//        setupNewsNetworkService()
//        registerImageLoader()
//        registerImageLoaderService()
    }
    
    private func setupAuthService() {
        let authSerice: AuthServiceProtocol = AuthService()
        ServiceLocator.shared.addService(service: authSerice)
    }
//    private func setupApiManager() {
//        let apiManager: ApiManagerProtocol = ApiManager.shared
//        ServiceLocator.shared.addService(service: apiManager)
//    }
//    
//    private func setupNewsNetworkService() {
//        let newsNetworkService: NewsNetworkServiceProtocol = NewsNetworkService()
//        ServiceLocator.shared.addService(service: newsNetworkService)
//    }
//    
//    private func registerImageLoader() {
//        let imageLoader: ImageLoaderProtocol = ImageLoader.shared
//        ServiceLocator.shared.addService(service: imageLoader)
//    }
//    
//    private func registerImageLoaderService() {
//        let imageLoaderService: ImageLoaderServiceProtocol = ImageLoaderService()
//        ServiceLocator.shared.addService(service: imageLoaderService)
//    }
}
