//
//  ViewState.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 16/11/24.
//

enum ViewState: Equatable {
    case loading
    case idle
    case error(String)
    case empty
}
