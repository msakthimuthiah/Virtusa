
import Foundation

class HomePresenter: ViewToPresenterHomeProtocol {

    // MARK: Properties
    weak var view: PresenterToViewHomeProtocol?
    var interactor: PresenterToInteractorHomeProtocol?
    var router: PresenterToRouterHomeProtocol?
    
    func viewDidLoad() {
        print("Presenter is being notified that the View was loaded.")
    }
    
    func navigateToContacts() {
        router?.pushToPeopleItemList(on view: self.view!)
    }

    func navigateToBoardrooms() {
        router?.pushToBoardroomItemList(on view: self.view!)
    }

}

extension HomePresenter: InteractorToPresenterHomeProtocol {
    
}
