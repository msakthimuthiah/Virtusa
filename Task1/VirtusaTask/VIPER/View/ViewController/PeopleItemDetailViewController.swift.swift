
import UIKit

class PeopleItemDetailViewController: UIViewController {


    // MARK: - Properties
    var presenter: ViewToPresenterPeopleItemDetailProtocol?
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var jobTitleLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var favoriteColorLbl: UILabel!
    @IBOutlet weak var favoriteColorBtn: UIButton!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        presenter?.viewDidLoad()
    }

}

extension PeopleItemDetailViewController: 

PresenterToViewPeopleItemDetailProtocol {

    func setUp(peopleItem: PeopleItem) {
        var name = ""
        if let firstName = peopleItem.firstName, firstName.count > 

0 {
            name = firstName
        }
        if let lastName = peopleItem.lastName, lastName.count > 0 

{
            name = name + lastName
        }

        let fontUtility = FontUtility()
        let bodyFontTextStyle = fontUtility.bodyFontTextStyle
        let headlineFontTextStyle = fontUtility.headlineFontTextStyle

        if(name.count > 0) {
	    let nameTitle = NSLocalizedString("Name_Title", 

comment: "")
            nameLbl = fontUtility.getLabelWithFontAndDynamicTyping(label: nameLbl, textStyle: bodyFontTextStyle)
            nameLbl.text = nameTitle + ": " + name
        }
        if let id = peopleItem.id {
	    let idTitle = NSLocalizedString("Id_Title", comment: 

"")
            idLbl = fontUtility.getLabelWithFontAndDynamicTyping(label: idLbl, textStyle: bodyFontTextStyle)
            idLbl.text = idTitle + ": " + id
        }
        if let jobTitle = peopleItem.jobTitle, jobTitle.count > 0 

{
	    let jobTitlePrefix = NSLocalizedString

("JobTitle_Title", comment: "")
            jobTitleLbl = fontUtility.getLabelWithFontAndDynamicTyping(label: jobTitleLbl, textStyle: bodyFontTextStyle)
            jobTitleLbl.text = jobTitlePrefix + ": " + jobTitle
        }
        if let email = peopleItem.email {
	    let emailTitle = NSLocalizedString("Email_Title", 

comment: "")
            emailLbl = fontUtility.getLabelWithFontAndDynamicTyping(label: emailLbl, textStyle: bodyFontTextStyle)
            emailLbl.text = emailTitle + ": " + email
        }
        if let favouriteColor = peopleItem.favouriteColor {
	    let favoriteColorTitle = NSLocalizedString

("Favourite_Color_Title", comment: "")
            favoriteColorLbl = fontUtility.getLabelWithFontAndDynamicTyping(label: favoriteColorLbl, textStyle: bodyFontTextStyle)
            favoriteColorLbl.text = favoriteColorTitle + ": " 
            favoriteColorBtn.isUserInteractionEnabled = false
            favoriteColorBtn = FontUtility().getFormattedButton

(button: favoriteColorBtn, title: favouriteColor)
        }
    }
    
    func onGetImageFromURLSuccess(peopleItem: PeopleItem, 

userImage: UIImage?) {
        print("View receives the response from Presenter and 

updates itself.")
        self.userImageView.image = userImage
    }
    
    func onGetImageFromURLFailure(peopleItem: PeopleItem) {
        print("View receives the response from Presenter and 

updates itself.")
        let defaultImage = UIImage(named: "ProfileUserImage")
        self.userImageView.image = defaultImage
    }
    
}

// MARK: - UI Setup
extension PeopleItemDetailViewController {
    func setupUI() {
        overrideUserInterfaceStyle = .light
        
        self.view.backgroundColor = .white
        FontUtility().setUpNavigationBar()
        let contactDetailsTitle = NSLocalizedString("Contact_Details_Title", comment: "")
        self.navigationItem.title = contactDetailsTitle

	self.userImageView.layer.cornerRadius = self.userImageView.frame.size.width / 2
	self.userImageView.clipsToBounds = true

	let customBackButton = UIBarButtonItem(image: UIImage(named: "backArrow") , style: .plain, target: self, action: #selector(backAction(sender:)))
    customBackButton.imageInsets = UIEdgeInsets(top: 2, left: -8, bottom: 0, right: 0)
    navigationItem.leftBarButtonItem = customBackButton
    }
    
	func backAction(sender: UIBarButtonItem) {
    presenter?.popBack()
}
}
