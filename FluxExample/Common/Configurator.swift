//
//  Configurator.swift
//  FluxExample
//
//  Created by artembolotov on 08.02.2023.
//

import Foundation
import ApiManager

final class Configurator {
    static let shared = Configurator()
    
    private init() {}
    
    func setup() {
        registerAuthService()
        registerApiManager()
        registerNewsNetworkService()
//        setupApiManager()
//        setupNewsNetworkService()
//        registerImageLoader()
//        registerImageLoaderService()
    }
    
    private func registerAuthService() {
        let authSerice: AuthServiceProtocol = AuthService()
        ServiceLocator.shared.addService(service: authSerice)
    }
    
    private func registerApiManager() {
        let apiManager: ApiManagerProtocol = ApiManager.shared
        ServiceLocator.shared.addService(service: apiManager)
    }
    
    private func registerNewsNetworkService() {
        let newNetworkService: NewsNetworkServiceProtocol = NewsNetworkService()
        ServiceLocator.shared.addService(service: newNetworkService)
    }
    
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
