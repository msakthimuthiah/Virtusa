
import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewHomeProtocol: class {
    
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterHomeProtocol: class {
    
    var view: PresenterToViewHomeProtocol? { get set }
    var interactor: PresenterToInteractorHomeProtocol? { get set }
    var router: PresenterToRouterHomeProtocol? { get set }

    func viewDidLoad()
    func navigateToContacts()
    func navigateToBoardrooms()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorHomeProtocol: class {
    
    var presenter: InteractorToPresenterHomeProtocol? { get set }
    
    
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterHomeProtocol: class {
    
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterHomeProtocol: class {
    
    static func createModule() -> UINavigationController
    func pushToPeopleItemList(on view: PresenterToViewHomeProtocol)
    func pushToBoardroomItemList(on view: PresenterToViewHomeProtocol)
}
