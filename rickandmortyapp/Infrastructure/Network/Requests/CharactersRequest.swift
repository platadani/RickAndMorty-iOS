//
//  CharactersRequest.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 13/11/24.
//

import Foundation

class CharactersRequestConfiguration {
    func makeCharactersURL(queryParams: [String: String]?) -> URL? {
        let baseURL = APIConfiguration.baseURL

        var components = URLComponents(string: baseURL)

        if let queryParams, !queryParams.isEmpty {
            components?.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        components?.path = "/api/character"
        return components?.url
    }
}
