//
//  APIClientProtocol.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 13/11/24.
//
import Foundation

protocol APIClientProtocol {
    func request<T: Decodable>(url: URL, method: HTTPMethod) async throws -> T
}
