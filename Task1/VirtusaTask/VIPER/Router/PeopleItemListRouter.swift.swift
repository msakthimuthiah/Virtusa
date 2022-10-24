
import UIKit

class PeopleItemListRouter: PresenterToRouterPeopleItemListProtocol {
    
    
    // MARK: Static methods
    static func createModule() -> PeopleItemListViewController {
        
        print("PeopleItemListRouter creates the PeopleItemList module.")
        let viewController = PeopleItemListViewController()
        
        let presenter: ViewToPresenterPeopleItemListProtocol & InteractorToPresenterPeopleItemListProtocol = PeopleItemListPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = PeopleItemListRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = PeopleItemListInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    // MARK: - Navigation
    func pushToPeopleItemDetail(on view: PresenterToViewPeopleItemListProtocol, with peopleItem: PeopleItem) {
        print("PeopleItemListRouter is instructed to push PeopleItemDetailViewController onto the navigation stack.")
        let peopleItemDetailViewController = PeopleItemDetailRouter.createModule(with: peopleItem)
            
        let viewController = view as! PeopleItemListViewController
        viewController.navigationController?
            .pushViewController(peopleItemDetailViewController, animated: true)
        
    }

	func popBack(on view: PresenterToViewPeopleItemListProtocol) {
        let viewController = view as! PeopleItemListViewController
        viewController.navigationController?
            .popViewController(animated: true)
        
    }
    
}
