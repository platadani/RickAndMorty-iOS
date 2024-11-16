//
//  MockAPIClient.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 15/11/24.
//

import Foundation
@testable import rickandmortyapp

class MockAPIClient: APIClientProtocol {
    var shouldReturnError = false

    func request<T: Decodable>(url: URL, method: HTTPMethod) async throws -> T {
        if shouldReturnError {
            throw CustomError.unknown
        } else {
            return RickAndMortyResponse.mock as! T
        }
    }
}
