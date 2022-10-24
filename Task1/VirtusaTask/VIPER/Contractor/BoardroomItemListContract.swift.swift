
import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewBoardroomItemListProtocol: class {
    func onFetchBoardroomItemListSuccess()
    func onFetchBoardroomItemListFailure(error: String)
    
    func showHUD()
    func hideHUD()
    
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterBoardroomItemListProtocol: class {
    
    var view: PresenterToViewBoardroomItemListProtocol? { get set }
    var interactor: PresenterToInteractorBoardroomItemListProtocol? { get set }
    var router: PresenterToRouterBoardroomItemListProtocol? { get set }
    
    var boardroomItemList: [BoardroomItem]? { get set }
    var sections = [SectionBoardroom]()? { get set }
    var searchedBoardroomItemList: [BoardroomItem]? { get set }
    var searchedSections = [SectionBoardroom]()? { get set }
    var searching = false { get set }
    
    func viewDidLoad()
    func popBack()

    func refresh()
    
    func numberOfRowsInSection(section: Int) -> Int
    func numberOfSections() -> Int
    func makeIndexAndSectionInBoardrooms()
    func getBoardroomItemAt(indexpath: IndexPath) -> BoardroomItem
    func getSectionList() -> [Section]?

    func handleSearch(isSearching: Bool, searchText: String)

}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorBoardroomItemListProtocol: class {
    
    var presenter: InteractorToPresenterBoardroomItemListProtocol? { get set }
    
    func loadBoardroomItemList()
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterBoardroomItemListProtocol: class {
    
    func fetchBoardroomItemListSuccess(boardroomItemList: [BoardroomItem])
    func fetchBoardroomItemListFailure(errorCode: Int)
    
    func getBoardroomItemSuccess(_ boardroomItem: BoardroomItem)
    func getBoardroomItemFailure()
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterBoardroomItemListProtocol: class {
    
    static func createModule() -> BoardroomItemListViewController
    
    func popBack(on view: PresenterToViewBoardroomItemListProtocol)
}
