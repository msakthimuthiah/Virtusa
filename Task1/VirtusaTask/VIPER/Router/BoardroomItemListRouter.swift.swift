
import UIKit

class BoardroomItemListRouter: 

PresenterToRouterBoardroomItemListProtocol {
    
    
    // MARK: Static methods
    static func createModule() -> BoardroomItemListViewController {
        
        print("BoardroomItemListRouter creates the BoardroomItemList 

module.")
        let viewController = BoardroomItemListViewController()
        
        let presenter: ViewToPresenterBoardroomItemListProtocol & 

InteractorToPresenterBoardroomItemListProtocol = 

BoardroomItemListPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = BoardroomItemListRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = 

BoardroomItemListInteractor()
        viewController.presenter?.interactor?.presenter = 

presenter
        
        return viewController
    }
    
    // MARK: - Navigation
    func popBack(on view: 

PresenterToViewBoardroomItemListProtocol) {
        let viewController = view as! BoardroomItemListViewController
        viewController.navigationController?
            .popViewController(animated: true)
        
    }
    
}
