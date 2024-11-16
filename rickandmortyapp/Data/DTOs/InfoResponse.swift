//
//  InfoResponse.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 13/11/24.
//

import Foundation

struct InfoResponse: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?

    var nextPage: Int? {
        if let urlString = next,
           let url = URL(string: urlString),
           let pageValue = url.queryValue(for: "page"),
           let pageNumber = Int(pageValue) {
            return pageNumber
        } else {
            return nil
        }
    }
}
