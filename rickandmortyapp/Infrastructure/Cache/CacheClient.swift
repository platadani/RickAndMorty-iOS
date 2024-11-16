//
//  CacheClient.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 16/11/24.
//

import Foundation

class CacheClient: CacheClientProtocol {
    private let cache = NSCache<NSString, NSData>()

    func setCache<T: Encodable>(for key: String, decodable: T) throws {
        do {
            let encodedData = try JSONEncoder().encode(decodable)
            cache.setObject(encodedData as NSData, forKey: key as NSString)
        } catch {
            throw CacheError.savingError
        }
    }

    func getCache<T: Decodable>(for key: String) throws -> T {
        guard let data = cache.object(forKey: key as NSString) as Data? else { throw CacheError.notCacheFound }
        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw CacheError.notCacheFound
        }
    }
}
