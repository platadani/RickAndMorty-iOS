//
//  SearchFiltersTests.swift
//  rickandmortyappTests
//
//  Created by Daniel Plata on 16/11/24.
//

import XCTest
@testable import rickandmortyapp

final class SearchFiltersTests: XCTestCase {
    var searchFilters: SearchFilters!

    override func setUp() {
        super.setUp()
        searchFilters = SearchFilters()
    }

    override func tearDown() {
        searchFilters = nil
        super.tearDown()
    }

    func testSetStatus() {
        searchFilters.setStatus(.alive)
        XCTAssertEqual(searchFilters.characterStatus, .alive)
    }

    func testSetGender() {
        searchFilters.setGender(.male)
        XCTAssertEqual(searchFilters.characterGender, .male)
    }

    func testStatusNilIfSetSameStatusSelected() {
        searchFilters.setStatus(.alive)
        searchFilters.setStatus(.alive)
        XCTAssertNil(searchFilters.characterGender)
    }

    func testGenderNilIfSetSameGenderSelected() {
        searchFilters.setGender(.male)
        searchFilters.setGender(.male)
        XCTAssertNil(searchFilters.characterGender)
    }

    func testEmptyQueryParametersIfNoFiltersSelected() {
        XCTAssertEqual(searchFilters.toQueryParameters(), [:])
    }

    func testQueryParametersIfNameQueryWasSet() {
        searchFilters.nameQuery = "Rick"
        XCTAssertEqual(searchFilters.toQueryParameters(), ["name": "Rick"])
    }

    func testQueryParametersIfNameQueryWasSetAndStatusWasSeletec() {
        searchFilters.nameQuery = "Rick"
        searchFilters.setGender(.genderless)
        XCTAssertEqual(searchFilters.toQueryParameters(), ["name": "Rick", "gender": "Genderless"])
    }
}
