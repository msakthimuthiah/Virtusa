
import UIKit

class BoardroomItemCell: UITableViewCell {
    
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var maxOccupancyLbl: UILabel!
    @IBOutlet weak var availabilityIndicatorLbl: UILabel!
    
    var sourceVC: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(boardroomItem: BoardroomItem) {
        
	
        let fontUtility = FontUtility()
        let bodyFontTextStyle = fontUtility.bodyFontTextStyle
        let headlineFontTextStyle = fontUtility.headlineFontTextStyle

        if let id = boardroomItem.id, id.count > 0 {
	    let idTitle = NSLocalizedString("Id_Title", comment: "")
		idLbl = fontUtility.getLabelWithFontAndDynamicTyping(label: idLbl, textStyle: bodyFontTextStyle)
            idLbl.text = idTitle + ": " + id
        }
        if let maxOccupancy = boardroomItem.maxOccupancy, maxOccupancy > 0 {
	    let maxOccupanyTitle = NSLocalizedString("MaxOccupancy_Title", comment: "")
		maxOccupancyLbl = fontUtility.getLabelWithFontAndDynamicTyping(label: maxOccupancyLbl, textStyle: bodyFontTextStyle)
            maxOccupancyLbl.text = maxOccupanyTitle + ": " + maxOccupancy
        }
	availabilityIndicatorLbl = fontUtility.getLabelWithFontAndDynamicTyping(label: availabilityIndicatorLbl, textStyle: headlineFontTextStyle)
	availabilityIndicatorLbl.text = boardroomItem.isAvailable ? "A" : "NA"
        

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
