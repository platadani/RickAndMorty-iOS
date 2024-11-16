import XCTest
@testable import rickandmortyapp

class FetchCharactersUseCaseTests: XCTestCase {
    var charactersRepository: MockCharactersRepository!
    var fetchCharactersUseCase: FetchCharactersUseCaseImpl!

    override func setUp() {
        super.setUp()
        charactersRepository = MockCharactersRepository()
        fetchCharactersUseCase = FetchCharactersUseCaseImpl(repository: charactersRepository)
    }

    override func tearDown() {
        charactersRepository = nil
        fetchCharactersUseCase = nil
        super.tearDown()
    }

    func testExecuteSuccess() async {
        let expectation = XCTestExpectation(description: "Fetch characters successfully")
        do {
            let _ = try await fetchCharactersUseCase.execute(filters: SearchFilters())
            expectation.fulfill()
        } catch {
            XCTFail("Expected success but got failure")
        }
    }

    func testExecuteFailure() async {
        charactersRepository.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Fetch characters with failure")
        do {
            let _ = try await fetchCharactersUseCase.execute(filters: SearchFilters())
            XCTFail("Expected failure but got success")
        } catch {
            expectation.fulfill()
        }
    }

    func testNoMoreDataAvailableBeforeFetchCharacters() {
        let isMoreDataAvailable = fetchCharactersUseCase.isMoreDataAvailable()
        XCTAssertFalse(isMoreDataAvailable)
    }

    func testMoreDataAvailableAfterFetchCharacters() async {
        charactersRepository.mockResponse = .mockWithNextPage
        do {
            let _ = try await fetchCharactersUseCase.execute(filters: SearchFilters())
            let isMoreDataAvailable = fetchCharactersUseCase.isMoreDataAvailable()
            XCTAssertTrue(isMoreDataAvailable)
        } catch {
            XCTFail("Expected success but got failure")
        }
    }

    func testNoMoreDataAvailableAfterFetchCharactersButNoNextURLInResponse() async {
        charactersRepository.mockResponse = .mock
        do {
            let _ = try await fetchCharactersUseCase.execute(filters: SearchFilters())
            let isMoreDataAvailable = fetchCharactersUseCase.isMoreDataAvailable()
            XCTAssertFalse(isMoreDataAvailable)
        } catch {
            XCTFail("Expected success but got failure")
        }
    }
}

extension RickAndMortyResponse {
    static var mockWithNextPage: RickAndMortyResponse {
        RickAndMortyResponse(info: InfoResponse(count: 1,
                                                pages: 1,
                                                next: "https://rickandmortyapi.com/api/character?page=2",
                                                prev: ""),
                             results: [CharacterResponse.mock])
    }
}
