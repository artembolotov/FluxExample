//
//  Injected.swift
//  FluxExample
//
//  Created by artembolotov on 08.02.2023.
//

import Foundation

@propertyWrapper
struct Injected<Service> {
    private var service: Service?
    
    public var wrappedValue: Service {
        mutating get {
            if service == nil {
                service = ServiceLocator.shared.getService()
            }
            return service!
        }
    }
    
    public var projectedValue: Injected<Service> {
        mutating set {
            self = newValue
        }
        get {
            return self
        }
    }
}
