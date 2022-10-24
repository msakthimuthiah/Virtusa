
import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewPeopleItemDetailProtocol: class {
    
    func setUp(peopleItem: PeopleItem)
    func onGetImageFromURLSuccess(peopleItem: PeopleItem, userImage: UIImage?)
    func onGetImageFromURLFailure(peopleItem: PeopleItem)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterPeopleItemDetailProtocol: class {
    
    var view: PresenterToViewPeopleItemDetailProtocol? { get set }
    var interactor: PresenterToInteractorPeopleItemDetailProtocol? { get set }
    var router: PresenterToRouterPeopleItemDetailProtocol? { get set }

    func viewDidLoad()

}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorPeopleItemDetailProtocol: class {
    
    var presenter: InteractorToPresenterPeopleItemDetailProtocol? { get set }
    
    var peopleItem: PeopleItem? { get set }
    
    func getPeopleItem()
    func getImageDataFromURL()
    
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterPeopleItemDetailProtocol: class {
    
    func setUp(peopleItem: PeopleItem)
    func getImageFromURLSuccess(peopleItem: PeopleItem, userImage: UIImage?)
    func getImageFromURLFailure(peopleItem: PeopleItem)
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterPeopleItemDetailProtocol: class {
    
    static func createModule() -> PeopleItemDetailViewController
    func popBack(on view: PresenterToViewPeopleItemDetailProtocol)
}
