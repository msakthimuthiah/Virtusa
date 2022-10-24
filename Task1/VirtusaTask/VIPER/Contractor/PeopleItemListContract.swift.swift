
import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewPeopleItemListProtocol: class {
    func onFetchPeopleItemListSuccess()
    func onFetchPeopleItemListFailure(error: String)
    
    func showHUD()
    func hideHUD()
    
    func deselectRowAt(row: Int)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterPeopleItemListProtocol: class {
    
    var view: PresenterToViewPeopleItemListProtocol? { get set }
    var interactor: PresenterToInteractorPeopleItemListProtocol? { get set }
    var router: PresenterToRouterPeopleItemListProtocol? { get set }
    
    var peopleItemList: [PeopleItem]? { get set }
    var sections = [Section]()? { get set }
    var searchedPeopleItemList: [PeopleItem]? { get set }
    var searchedSections = [Section]()? { get set }
    var searching = false { get set }
    
    func viewDidLoad()
    func popBack()
    
    func refresh()
    
    func numberOfRowsInSection(section: Int) -> Int
    func numberOfSections() -> Int
    func makeIndexAndSectionInContacts()
    func getPeopleItemAt(indexpath: IndexPath) -> PeopleItem
    func getSectionList() -> [Section]?

    func didSelectRowAt(indexpath: IndexPath)
    func deselectRowAt(indexpath: IndexPath)
    func handleSearch(isSearching: Bool, searchText: String)

}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorPeopleItemListProtocol: class {
    
    var presenter: InteractorToPresenterPeopleItemListProtocol? { get set }
    
    func loadPeopleItemList()
    func retrievePeopleItem(peopleItem: PeopleItem)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterPeopleItemListProtocol: class {
    
    func fetchPeopleItemListSuccess(peopleItemList: [PeopleItem])
    func fetchPeopleItemListFailure(errorCode: Int)
    
    func getPeopleItemSuccess(_ peopleItem: PeopleItem)
    func getPeopleItemFailure()
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterPeopleItemListProtocol: class {
    
    static func createModule() -> PeopleItemListViewController
    
    func pushToPeopleItemDetail(on view: PresenterToViewPeopleItemListProtocol, with peopleItem: PeopleItem)
    func popBack(on view: PresenterToViewPeopleItemListProtocol)
}
