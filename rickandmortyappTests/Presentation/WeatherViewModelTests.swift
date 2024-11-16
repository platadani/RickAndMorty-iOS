import XCTest
@testable import rickandmortyapp

@MainActor
class CharactersViewModelTests: XCTestCase {
    var fetchCharactersUseCase: MockFetchCharactersUseCase!
    var charactersViewModel: CharactersViewModel!

    override func setUp() {
        super.setUp()
        fetchCharactersUseCase = MockFetchCharactersUseCase()
        charactersViewModel = CharactersViewModel(fetchCharactersUseCase: fetchCharactersUseCase)
    }

    override func tearDown() {
        fetchCharactersUseCase = nil
        charactersViewModel = nil
        super.tearDown()
    }

    func testFetchCharactersSuccess() async {
        await charactersViewModel.fetchCharacters()
        XCTAssertNotNil(charactersViewModel.rmCharacters)
    }

    func testMoreDataAvailableForPagination() async {
        fetchCharactersUseCase.shouldMoreDataAvailable = true
        await charactersViewModel.fetchCharacters()
        XCTAssertTrue(charactersViewModel.isMoreDataAvailable)
    }

    func testViewStateIsErrorIfUseCaseReturnsError() async {
        fetchCharactersUseCase.shouldReturnError = true
        await charactersViewModel.fetchCharacters()
        XCTAssertTrue(charactersViewModel.viewState == .error("Unknown error"))
    }

    func testViewStateIsIdleIfUseCaseNotReturnsError() async {
        fetchCharactersUseCase.shouldReturnError = false
        await charactersViewModel.fetchCharacters()
        XCTAssertTrue(charactersViewModel.viewState == .idle)
    }

    func testViewStateIsEmptyIfUseCaseReturnsEmptyCharacters() async {
        fetchCharactersUseCase.mockCharacters = []
        await charactersViewModel.fetchCharacters()
        XCTAssertTrue(charactersViewModel.viewState == .empty)
    }

    func testCharactersCount() async {
        fetchCharactersUseCase.mockCharacters = [.mock, .mock]
        await charactersViewModel.fetchCharacters()
        XCTAssertEqual(charactersViewModel.rmCharacters?.count, 2)
    }

    func testCharactersIsEmptyIfUseCaseReturnsError() async {
        fetchCharactersUseCase.shouldReturnError = true
        await charactersViewModel.fetchCharacters()
        XCTAssertEqual(charactersViewModel.rmCharacters?.count, 0)
    }
}

