
import UIKit

class HomeViewController: UIViewController {

    // MARK: - Properties
    var presenter: ViewToPresenterHomeProtocol?

    @IBOutlet weak var contactsBtn: UIButton!
    @IBOutlet weak var boardroomsBtn: UIButton!

    @IBAction func contactsAction(_sender : AnyObject) {
	presenter?.navigateToContacts()
    }
    @IBAction func boardroomsAction(_sender : AnyObject) {
	presenter?.navigateToBoardrooms()
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        presenter?.viewDidLoad()
    }

    
}

extension HomeViewController: 

PresenterToViewHomeProtocol {

}

// MARK: - UI Setup
extension HomeViewController {
    func setupUI() {
        overrideUserInterfaceStyle = .light
        
        self.view.backgroundColor = .white
        FontUtility().setUpNavigationBar()
        let virtusaTaskTitle = NSLocalizedString("VirtusaTask_Title", comment: "")
        self.navigationItem.title = virtusaTaskTitle

        let contactsTitle = NSLocalizedString("Contacts_Title", comment: "")
        contactsBtn = FontUtility().getFormattedButton(button: contactsBtn, title: contactsTitle)
        let boardroomsTitle = NSLocalizedString("Boardrooms_Title", comment: "")
        boardroomsBtn = FontUtility().getFormattedButton(button: boardroomsBtn, title: boardroomsTitle)

    }
    
}
