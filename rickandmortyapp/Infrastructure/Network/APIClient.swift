//
//  APIClient.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 13/11/24.
//
import Foundation

class APIClient: APIClientProtocol {
    private let session: URLSession
    private let validHttpCodes = (200...299)

    init(session: URLSession = .shared) {
        self.session = session
    }

    func request<T: Decodable>(url: URL, method: HTTPMethod) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        do {
            let (data, response) = try await session.data(for: request)
            if let httpResponse = response as? HTTPURLResponse, !validHttpCodes.contains(httpResponse.statusCode) {
                let statusCode = httpResponse.statusCode
                if statusCode == 404 {
                    throw CustomError.notFound
                } else {
                    throw CustomError.httpError(httpResponse.statusCode)
                }
            }
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw error
        }
    }
}
