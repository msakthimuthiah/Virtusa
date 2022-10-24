
import UIKit

class PeopleItemDetailRouter: PresenterToRouterPeopleItemDetailProtocol {
    
    
    // MARK: Static methods
    static func createModule() -> PeopleItemDetailViewController {
        
        print("PeopleItemDetailRouter creates the PeopleItemDetail module.")
        let viewController = PeopleItemDetailViewController()
        
        let presenter: ViewToPresenterPeopleItemDetailProtocol & InteractorToPresenterPeopleItemDetailProtocol = PeopleItemDetailPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = PeopleItemDetailRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = PeopleItemDetailInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    // MARK: - Navigation
    func popBack(on view: PresenterToViewPeopleItemDetailProtocol) {
       
        let viewController = view as! PeopleItemDetailViewController
        viewController.navigationController?.popViewController(animated: true)
        
    }
    
}
