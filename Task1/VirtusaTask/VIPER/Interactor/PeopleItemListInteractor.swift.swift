
import Foundation

public class PeopleItemListInteractor: PresenterToInteractorPeopleItemListProtocol {
    
    // MARK: Properties
    public weak var presenter: InteractorToPresenterPeopleItemListProtocol?
    public var peopleItemList: [PeopleItem]?
    
    public func loadPeopleItemList() {
	let checkInService = CheckInService()
	if(checkInService.isInternetConnected()) {
        checkInService.getPeopleListApiCall { (statusCode, peopleItemList) in 
                if(statusCode == SUCCESS_STATUSCODE) {
                    self.peopleItemList = peopleItemList
                    self.presenter?.fetchPeopleItemListSuccess(peopleItemList:self.peopleItemList)
                } else {
                    self.presenter?.fetchPeopleItemListFailure(errorCode: statusCode)
                }
            }
	} else {
		self.presenter?.fetchPeopleItemListFailure(errorCode: FAILURE_GENERIC_STATUSCODE)
	}

    }

    
    public func retrievePeopleItem(peopleItem: PeopleItem) {
        guard let peopleItem = peopleItem else {
            self.presenter?.getPeopleItemFailure()
            return
        }
        self.presenter?.getPeopleItemSuccess(peopleItem)
    }

    
}
