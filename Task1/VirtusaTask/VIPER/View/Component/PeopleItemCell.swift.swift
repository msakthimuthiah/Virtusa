
import UIKit

class PeopleItemCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var jobTitleLbl: UILabel!
    
    var sourceVC: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(peopleItem: PeopleItem) {
        
        var name = ""
        if let firstName = peopleItem.firstName, firstName.count > 0 {
            name = firstName
        }
        if let lastName = peopleItem.lastName, lastName.count > 0 {
            name = name + lastName
        }

        let fontUtility = FontUtility()
        let bodyFontTextStyle = fontUtility.bodyFontTextStyle

        if(name.count > 0) {
	    let nameTitle = NSLocalizedString("Name_Title", comment: "")
		nameLbl = fontUtility.getLabelWithFontAndDynamicTyping(label: nameLbl, textStyle: bodyFontTextStyle)
            nameLbl.text = nameTitle + ": " + name
        }
        if let jobTitle = peopleItem.jobTitle, jobTitle.count > 0 {
	    let jobTitlePrefix = NSLocalizedString("JobTitle_Title", comment: "")
		jobTitleLbl = fontUtility.getLabelWithFontAndDynamicTyping(label: jobTitleLbl, textStyle: bodyFontTextStyle)
            jobTitleLbl.text = jobTitlePrefix + ": " + jobTitle
        }

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
