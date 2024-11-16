//
//  URLExtension.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 15/11/24.
//

import Foundation

extension URL {
    func queryValue(for name: String) -> String? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else {
            return nil
        }
        return queryItems.first(where: { $0.name == name })?.value
    }
}
