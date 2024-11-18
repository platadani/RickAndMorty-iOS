import XCTest
@testable import rickandmortyapp

class CharactersRepositoryTests: XCTestCase {
    var dataSource: MockCharactersDataSource!
    var charactersRepository: CharactersRepositoryImpl!

    override func setUp() {
        super.setUp()
        dataSource = MockCharactersDataSource()
        charactersRepository = CharactersRepositoryImpl(dataSource: dataSource)
    }

    override func tearDown() {
        dataSource = nil
        charactersRepository = nil
        super.tearDown()
    }

    func testFetchCharactersSuccess() async {
        let expectation = XCTestExpectation(description: "Fetch characters successfully")
        do {
            let _ = try await charactersRepository.fetchCharacters(queryParams: [:])
            expectation.fulfill()
        } catch {
            XCTFail("Expected success but got failure")
        }
    }

    func testFetchCharactersCountSuccess() async {
        let expectation = XCTestExpectation(description: "Fetch characters successfully")
        do {
            let (characters, _) = try await charactersRepository.fetchCharacters(queryParams: [:])
            XCTAssertEqual(characters.count, 1)
            expectation.fulfill()
        } catch {
            XCTFail("Expected success but got failure")
        }
    }

    func testFetchCharactersValuesSuccess() async {
        do {
            let (characters, _) = try await charactersRepository.fetchCharacters(queryParams: [:])
            XCTAssertEqual(characters.first?.gender, .male)
            XCTAssertEqual(characters.first?.status, .alive)
            XCTAssertEqual(characters.first?.name, "Rick Sanchez")
        } catch {
            XCTFail("Expected success but got failure")
        }
    }

    func testFetchCharactersFailure() async {
        dataSource.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Fetch characters failure")
        do {
            let _ = try await charactersRepository.fetchCharacters(queryParams: [:])
            XCTFail("Expected failure but got success")
        } catch {
            expectation.fulfill()
        }
    }
}
