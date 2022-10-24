
import Foundation

struct Section {
    let letter : String
    let peopleItemListInSection : [PeopleItem]
}

class PeopleItemListPresenter: ViewToPresenterPeopleItemListProtocol {
    
    // MARK: Properties
    weak var view: PresenterToViewPeopleItemListProtocol?
    var interactor: PresenterToInteractorPeopleItemListProtocol?
    var router: PresenterToRouterPeopleItemListProtocol?
    
    var peopleItemList: [PeopleItem]?
    var sections = [Section]()?
    var searchedPeopleItemList: [PeopleItem]?
    var searchedSections = [Section]()
    var searching = false
    
    // MARK: Inputs from view
    func viewDidLoad() {
        print("Presenter is being notified that the View was loaded.")
        view?.showHUD()
        interactor?.loadPeopleItemList()
    }

    func popBack() {
	router?.popBack(on view: self.view!)
    }
    
    func refresh() {
        print("Presenter is being notified that the View was refreshed.")
        interactor?.loadPeopleItemList()
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        guard let peopleItemList = self.peopleItemList, let sections = self.sections, sections.count > 0 else {
            return 0
        }
        
        if self.searching {
            return searchedSections[section].peopleItemListInSection.count
        } else {
        return sections[section].peopleItemListInSection.count
	}
    }

    func numberOfSections() -> Int {
        guard let peopleItemList = self.peopleItemList, let sections = self.sections, sections.count > 0 else {
            return 0
        }
        
	if self.searching {
            return searchedSections.count
	} else {
            return sections.count
	}
    }

    func makeIndexAndSectionInContacts() {
	guard let peopleItemList = self.peopleItemList else {
            return
        }

	var groupDictionary = Dictionary(grouping: peopleItemList, by: { String($0.firstName.prefix(1)) })
	if(self.searching) {
	  groupDictionary = Dictionary(grouping: searchedPeopleItemList, by: { String($0.firstName.prefix(1)) })
	}

        if let groupedDictionary = groupDictionary {
    	// get the keys and sort them
    	let keys = groupedDictionary.keys.sorted()
    	// map the sorted keys to a struct
    	sections = keys.map{ Section(letter: $0, peopleItemListInSection: groupedDictionary[$0]!.sorted()) }
	}
    }

    func getPeopleItemAt(indexpath: IndexPath) -> PeopleItem {
	var section = self.sections[indexPath.section]
	if self.searching {
	   section = self.searchedSections[indexPath.section]
	}
        let peopleItem = section.peopleItemListInSection[indexPath.row]
	return peopleItem
    }

    func getSectionList() -> [Section]? {
	if self.searching {
	  return self.searchedSections
	}
	return self.sections
    }
    
    func didSelectRowAt(indexpath: IndexPath) {
        interactor?.retrievePeopleItemList(peopleItem: self.getPeopleItemAt(indexpath: indexpath))
    }
    
    func deselectRowAt(indexpath: IndexPath) {
        view?.deselectRowAt(row: indexpath.row)
    }

    func handleSearch(isSearching: Bool, searchText: String) {
	if(isSearching) {
		self.searchedPeopleItemList = self.peopleItemList.filter { $0.firstName.lowercased().prefix(searchText.count) == searchText.lowercased() }
        
	}
	self.searching = isSearching
	self.makeIndexAndSectionInContacts()
    }
    

}

// MARK: - Outputs to view
extension PeopleItemListPresenter: InteractorToPresenterPeopleItemListProtocol {
    
    func fetchPeopleItemListSuccess(peopleItemList: [PeopleItem]) {
        print("Presenter receives the result from Interactor after it's done its job.")
        self.peopleItemList = peopleItemList
	self.makeIndexAndSectionInContacts()
        view?.hideHUD()
        view?.onFetchPeopleItemListSuccess()
    }
    
    func fetchPeopleItemListFailure(errorCode: Int) {
        print("Presenter receives the result from Interactor after it's done its job.")
        view?.hideHUD()
        let message = NSLocalizedString("Something_Went_Wrong_AlertMessage", comment: "")
        view?.onFetchPeopleItemListFailure(error: message)
    }
    
    func getPeopleItemSuccess(_ peopleItem: PeopleItem) {
        router?.pushToPeopleItemDetail(on: view!, with: peopleItem)
    }
    
    func getPeopleItemFailure() {
        view?.hideHUD()
        print("Couldn't retrieve peopleItem by index")
    }
    
    
}
