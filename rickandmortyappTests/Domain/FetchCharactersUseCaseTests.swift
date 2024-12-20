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
            let _ = try await fetchCharactersUseCase.execute(filters: .init())
            expectation.fulfill()
        } catch {
            XCTFail("Expected success but got failure")
        }
    }

    func testExecuteFailure() async {
        charactersRepository.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Fetch characters with failure")
        do {
            let _ = try await fetchCharactersUseCase.execute(filters: .init())
            XCTFail("Expected failure but got success")
        } catch {
            expectation.fulfill()
        }
    }

    func testNextPageAfterFetchCharacters() async {
        charactersRepository.nextPage = 2
        do {
            let (_, nextPage) = try await fetchCharactersUseCase.execute(filters: .init())
            XCTAssertEqual(nextPage, 2)
        } catch {
            XCTFail("Expected success but got failure")
        }
    }

    func testCharactersCountSuccess() async {
        charactersRepository.mockModel = [.mock, .mock, .mock]
        do {
            let (response, _) = try await fetchCharactersUseCase.execute(filters: .init())
            XCTAssertEqual(response.count, 3)
        } catch {
            XCTFail("Expected success but got failure")
        }
    }

    func testCharactersValues() async {
        charactersRepository.mockModel = [.mock, .mock, .mock]
        do {
            let (response, _) = try await fetchCharactersUseCase.execute(filters: .init())
            XCTAssertEqual(response.first?.gender, .male)
            XCTAssertEqual(response.first?.status, .alive)
            XCTAssertEqual(response.first?.species, "Human")
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
