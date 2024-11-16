//
//  CacheProtocol.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 16/11/24.
//

import Foundation

protocol CacheClientProtocol {
    func getCache<T: Decodable>(for key: String) throws -> T
    func setCache<T: Encodable>(for key: String, decodable: T) throws
}


