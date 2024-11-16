//
//  ImageCache.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 14/11/24.
//


import SwiftUI

actor ImageCache {
    static let shared = ImageCache()
    private var cache: [String: Image] = [:]
    
    func getImage(forKey key: String) -> Image? {
        return cache[key]
    }
    
    func setImage(_ image: Image, forKey key: String) {
        cache[key] = image
    }
}