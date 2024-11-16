//
//  NetworkError.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 13/11/24.
//

enum CustomError: Error {
    case notFound
    case httpError(Int)
    case invalidURL
    case nextURL
    case unknown

    var displayError: String? {
        switch self {
            case .notFound:
                nil
            case .httpError(let code):
                "Error: \(code)"
            case .invalidURL:
                String(localized: "error.invalidURL")
            case .nextURL:
                String(localized: "error.nextURL")
            case .unknown:
                String(localized: "error.unknown")
        }
    }
}
