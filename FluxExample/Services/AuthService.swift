//
//  AuthService.swift
//  FluxExample
//
//  Created by artembolotov on 07.02.2023.
//

import Foundation
import SwiftUI

protocol AuthServiceProtocol {
    func checkAuth() -> Bool
    func login()
    func logout()
}

final class AuthService: AuthServiceProtocol {
    
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    
    func checkAuth() -> Bool {
        return isLoggedIn
    }
    
    func login() {
        isLoggedIn = true
    }
    
    func logout() {
        isLoggedIn = false
    }
}
