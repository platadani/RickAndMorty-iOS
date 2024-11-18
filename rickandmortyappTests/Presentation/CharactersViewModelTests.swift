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

    func testNextPageAfterFetchCharacters() async {
        fetchCharactersUseCase.nextPage = 4
        await charactersViewModel.fetchCharacters()
        XCTAssertNotNil(charactersViewModel.nextPage)
    }

    func testViewStateIsErrorIfUseCaseReturnsError() async {
        fetchCharactersUseCase.shouldReturnError = true
        await charactersViewModel.fetchCharacters()
        XCTAssertTrue(charactersViewModel.viewState == .error(String(localized: "error.unknown")))
    }

    func testViewStateIsIdleIfUseCaseNotReturnsError() async {
        fetchCharactersUseCase.shouldReturnError = false
        await charactersViewModel.fetchCharacters()
        XCTAssertTrue(charactersViewModel.viewState == .idle)
    }

    func testViewStateIsEmptyIfUseCaseReturnsEmptyCharacters() async {
        fetchCharactersUseCase.mockModel = []
        await charactersViewModel.fetchCharacters()
        XCTAssertTrue(charactersViewModel.viewState == .empty)
    }

    func testCharactersCount() async {
        fetchCharactersUseCase.mockModel = [.mock, .mock]
        await charactersViewModel.fetchCharacters()
        XCTAssertEqual(charactersViewModel.rmCharacters?.count, 2)
    }

    func testCharactersIsEmptyIfUseCaseReturnsError() async {
        fetchCharactersUseCase.shouldReturnError = true
        await charactersViewModel.fetchCharacters()
        XCTAssertEqual(charactersViewModel.rmCharacters?.count, 0)
    }
}
