
import Foundation
import SDWebImage

class PeopleItemDetailInteractor: PresenterToInteractorPeopleItemDetailProtocol {
    
    // MARK: Properties
    weak var presenter: InteractorToPresenterPeopleItemDetailProtocol?
    var peopleItem: PeopleItem?

    func getPeopleItem() {
        self.presenter?.setUp(peopleItem: self.peopleItem)
    }
    
    func getImageDataFromURL() {
        print("Interactor receives the request from Presenter to get image data from the server.")
	let defaultImage = UIImage(named: "ProfileUserImage")
            
            if let profileImageUrl = self.peopleItem?.imageUrl {
                let userImage = UIImage().sd_setImage(with: profileImageUrl, placeholderImage: UIImage(named: "ProfileUserImage"))
self.presenter?.getImageFromURLSuccess(peopleItem: self.peopleItem, image: userImage)
            } else {
self.presenter?.getImageFromURLFailure(peopleItem: self.peopleItem)
}


    

}
