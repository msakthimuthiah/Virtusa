
import UIKit

class HomeRouter: PresenterToRouterHomeProtocol {
    
    
    // MARK: Static methods
    static func createModule() -> UINavigationController {
        
        print("HomeRouter creates the Home module.")
        let viewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter: ViewToPresenterHomeProtocol & InteractorToPresenterHomeProtocol = HomePresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = HomeRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = HomeInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return navigationController
    }
    
    // MARK: - Navigation
    func pushToPeopleItemList(on view: PresenterToViewHomeProtocol) {
        print("HomeRouter is instructed to push PeopleItemListViewController onto the navigation stack.")
        let peopleItemListViewController = PeopleItemListRouter.createModule()
            
        let viewController = view as! HomeViewController
        viewController.navigationController?
            .pushViewController(peopleItemListViewController, animated: true)
        
    }

    
    func pushToBoardroomItemList(on view: PresenterToViewHomeProtocol) {
        print("HomeRouter is instructed to push boardroomItemListViewController onto the navigation stack.")
        let boardroomItemListViewController = BoardroomItemListRouter.createModule()
            
        let viewController = view as! HomeViewController
        viewController.navigationController?
            .pushViewController(boardroomItemListViewController, animated: true)
        
    }

    
}
