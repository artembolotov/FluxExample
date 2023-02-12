//
//  Extensions.swift
//  FluxExample
//
//  Created by artembolotov on 10.02.2023.
//

import SwiftUI

extension View {
    @ViewBuilder func isHidden(_ isHidden: Bool) -> some View {
        if isHidden {
            self.hidden()
        } else {
            self
        }
    }
}

let prettyDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter
}()

public extension Article {
    var publishedAtPrettyDate: String? {
        guard let published = self.publishedAt,
              let date = OpenISO8601DateFormatter().date(from: published) else { return nil }
                
        return prettyDateFormatter.string(from: date)
    }
}
