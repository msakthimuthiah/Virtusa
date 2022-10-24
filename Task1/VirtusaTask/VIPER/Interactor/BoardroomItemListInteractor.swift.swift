
import Foundation

public class BoardroomItemListInteractor: PresenterToInteractorBoardroomItemListProtocol {
    
    // MARK: Properties
    public weak var presenter: InteractorToPresenterBoardroomItemListProtocol?
    public var boardroomItemList: [BoardroomItem]?
    
    public func loadBoardroomItemList() {
        let checkInService = CheckInService()
	if(checkInService.isInternetConnected()) {
        checkInService.getBoardroomListApiCall { (statusCode, boardroomItemList) in 
                if(statusCode == SUCCESS_STATUSCODE) {
                    self.boardroomItemList = boardroomItemList
                    self.presenter?.fetchBoardroomItemListSuccess(boardroomItemList:self.boardroomItemList)
                } else {
                    self.presenter?.fetchBoardroomItemListFailure(errorCode: statusCode)
                }
            }
	} else {
		self.presenter?.fetchBoardroomItemListFailure(errorCode: FAILURE_GENERIC_STATUSCODE)
	}
    }
    
}
