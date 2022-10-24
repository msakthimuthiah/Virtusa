
import Foundation

struct SectionBoardroom {
    let availability : String
    let boardroomItemListInSection : [BoardroomItem]
}

class BoardroomItemListPresenter: ViewToPresenterBoardroomItemListProtocol {
    
    // MARK: Properties
    weak var view: PresenterToViewBoardroomItemListProtocol?
    var interactor: PresenterToInteractorBoardroomItemListProtocol?
    var router: PresenterToRouterBoardroomItemListProtocol?
    
    var boardroomItemList: [BoardroomItem]?
    var sections = [SectionBoardroom]()?
    var searchedBoardroomItemList: [BoardroomItem]?
    var searchedSections = [SectionBoardroom]()
    var searching = false
    
    // MARK: Inputs from view
    func viewDidLoad() {
        print("Presenter is being notified that the View was loaded.")
        view?.showHUD()
        interactor?.loadBoardroomItemList()
    }
    
	
    func popBack() {
	router?.popBack(on view: self.view!)
    }
    
    func refresh() {
        print("Presenter is being notified that the View was refreshed.")
        interactor?.loadBoardroomItemList()
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        guard let boardroomItemList = self.boardroomItemList, let sections = self.sections, sections.count > 0 else {
            return 0
        }
        
        if self.searching {
            return searchedSections[section].boardroomItemListInSection.count
        } else {
        return sections[section].boardroomItemListInSection.count
	}
    }

    func numberOfSections() -> Int {
        guard let boardroomItemList = self.boardroomItemList, let sections = self.sections, sections.count > 0 else {
            return 0
        }
        
	if self.searching {
            return searchedSections.count
	} else {
            return sections.count
	}
    }

    func makeIndexAndSectionInBoardrooms() {
	guard let boardroomItemList = self.boardroomItemList else {
            return
        }

	let listToSegregate = self.searching ? searchedBoardroomItemList : boardroomItemList
	self.sections = [SectionBoardroom]()
	self.searchedSections = [SectionBoardroom]()
	let availableBoardroomItemList = listToSegregate.filter { $0.isAvailable == true } 
	let unavailableBoardroomItemList = listToSegregate.filter { $0.isAvailable == false }
	if(availableBoardroomItemList.count > 0) {
		let availableTitle = NSLocalizedString("Available_Title", comment: "")
		let availableSectionBoardroom = SectionBoardroom(availability: availableTitle, boardroomItemListInSection: availableBoardroomItemList)
		self.searching ? self.searchedSections.append(availableSectionBoardroom) : self.sections.append(availableSectionBoardroom)
	}
	if(unavailableBoardroomItemList.count > 0) {
		let unavailableTitle = NSLocalizedString("NotAvailable_Title", comment: "")
		let unavailableSectionBoardroom = SectionBoardroom(availability: unavailableTitle, boardroomItemListInSection: unavailableBoardroomItemList)
		self.searching ? self.searchedSections.append(unavailableSectionBoardroom) : self.sections.append(unavailableSectionBoardroom)
	}

    }

    func getBoardroomItemAt(indexpath: IndexPath) -> BoardroomItem {
	var section = self.sections[indexPath.section]
	if self.searching {
	   section = self.searchedSections[indexPath.section]
	}
        let boardroomItem = section.boardroomItemListInSection[indexPath.row]
	return boardroomItem
    }

    func getSectionList() -> [SectionBoardroom]? {
	if self.searching {
	  return self.searchedSections
	}
	return self.sections
    }
    
    func handleSearch(isSearching: Bool, searchText: String) {
	if(isSearching) {
		self.searchedBoardroomItemList = self.boardroomItemList.filter { $0.id.lowercased().prefix(searchText.count) == searchText.lowercased() }
        
	}
	self.searching = isSearching
	self.makeIndexAndSectionInBoardrooms()
    }
    

}

// MARK: - Outputs to view
extension BoardroomItemListPresenter: InteractorToPresenterBoardroomItemListProtocol {
    
    func fetchBoardroomItemListSuccess(boardroomItemList: [BoardroomItem]) {
        print("Presenter receives the result from Interactor after it's done its job.")
        self.boardroomItemList = boardroomItemList
	self.makeIndexAndSectionInBoardrooms()
        view?.hideHUD()
        view?.onFetchBoardroomItemListSuccess()
    }
    
    func fetchBoardroomItemListFailure(errorCode: Int) {
        print("Presenter receives the result from Interactor after it's done its job.")
        view?.hideHUD()
        let message = NSLocalizedString("Something_Went_Wrong_AlertMessage", comment: "")
        view?.onFetchBoardroomItemListFailure(error: message)
    }
    
    func getBoardroomItemSuccess(_ peopleItem: PeopleItem) {
        router?.pushToBoardroomItemDetail(on: view!, with: boardroomItem)
    }
    
    func getBoardroomItemFailure() {
        view?.hideHUD()
        print("Couldn't retrieve boardroomItem by index")
    }
    
    
}
