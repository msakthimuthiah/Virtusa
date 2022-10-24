
import UIKit

class ColorUtility {

    let brandColor = "#C40202"
    let brandUIColor = hexStringToUIColor(brandColor)
    let brandBackgroundUIColor = brandUIColor
    let brandForegroundUIColor = UIColor.white
    let whiteColor: UIColor = UIColor.white
    let blackColor: UIColor = UIColor.black
    let darkTextColor: UIColor = UIColor.darkText
    let lightTextColor: UIColor = UIColor.lightText

    func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

func getUIColorWithAccessibility() -> UIColor {
    let colorSupportsAccessibility = UIColor(dynamicProvider: { traitCollection in
    let interfaceStyle = traitCollection.userInterfaceStyle
    let colorContrast = traitCollection.accessibilityContrast
            switch (interfaceStyle, colorContrast)  {
            case (.dark, let contrast where contrast != .high):
                return self.whiteColor
            case (.light, let contrast where contrast != .high):
                return self.blackColor
            case (.dark, let contrast where contrast == .high):
                return self.lightTextColor
            case (.light, let contrast where contrast == .high):
                return self.darkTextColor
            case .unspecified:
                return UIColor.black
            }
        })
        return colorSupportsAccessibility
}

}