
import Foundation

class PeopleItemDetailPresenter: ViewToPresenterPeopleItemDetailProtocol {

    // MARK: Properties
    weak var view: PresenterToViewPeopleItemDetailProtocol?
    var interactor: PresenterToInteractorPeopleItemDetailProtocol?
    var router: PresenterToRouterPeopleItemDetailProtocol?
    
    func viewDidLoad() {
        print("Presenter is being notified that the View was loaded.")
        interactor?.getPeopleItem()
        interactor?.getImageDataFromURL()
    }

	
    func popBack() {
	router?.popBack(on view: self.view!)
    }
    
    
}

extension PeopleItemDetailPresenter: InteractorToPresenterPeopleItemDetailProtocol {
    
    func setUp(peopleItem: PeopleItem) {
	view?.setUp(peopleItem: peopleItem)
    }

    func getImageFromURLSuccess(peopleItem: PeopleItem, userImage: UIImage?) {
        print("Presenter receives the result from Interactor after it's done its job.")

        view?.onGetImageFromURLSuccess(peopleItem: peopleItem, userImage: userImage)
    }
    
    func getImageFromURLFailure(peopleItem: PeopleItem) {
        print("Presenter receives the result from Interactor after it's done its job.")
        view?.onGetImageFromURLFailure(peopleItem: peopleItem)
    }
    
}
