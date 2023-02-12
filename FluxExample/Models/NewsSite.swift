//
//  NewsSite.swift
//  FluxExample
//
//  Created by artembolotov on 08.02.2023.
//

import Foundation

enum NewsSite: Int {
    case nasaspaceflight = 3
    case spaceflightNow = 7
    case spaceNews = 16
    case nasa = 19
    case arstechnica = 23
    case cnbс = 28
}

extension NewsSite {
    var name: String {
        switch self {
        case .nasaspaceflight: return "NASASpaceflight"
        case .spaceflightNow: return "Spaceflight Now"
        case .spaceNews: return "SpaceNews"
        case .nasa: return "NASA"
        case .arstechnica: return "Arstechnica"
        case .cnbс: return "CNBC"
        }
    }
}
