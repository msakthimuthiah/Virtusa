
import UIKit

class FontUtility {

    let bodyFontTextStyle: UIFont.TextStyle = .body
    let headlineFontTextStyle: UIFont.TextStyle = .headline
    let titleFontTextStyle: UIFont.TextStyle = .title2

  func getUIFontByTextStyle(textStyle: UIFont.TextStyle) -> UIFont {
     return UIFont.preferredFont(forTextStyle: textStyle)
  }

  func getLabelWithFontAndDynamicTyping(label: UILabel, textStyle: UIFont.TextStyle) -> UILabel {
     label.numberOfLines = 0
     label.lineBreakMode = .byWordWrapping
     label.font = self.getUIFontByTextStyle(textStyle: textStyle)
     label.adjustsFontForContentSizeCategory = true
     label.textColor = ColorUtility().getUIColorWithAccessibility()
     return label
  }

   func getFormattedButton(button: UIButton, title: String) -> UIButton {
            button.setTitle(title.uppercased(), for: .normal)
            let colorUtility = ColorUtility()
            button.backgroundColor = colorUtility.brandBackgroundUIColor
            button.setTitleColor(colorUtility.brandForegroundUIColor, for: .normal)
            let fontUtility = FontUtility()
            button.titleLabel?.font = fontUtility.getUIFontByTextStyle(textStyle: fontUtility.headlineFontTextStyle)
            return button
}

func setUpNavigationBar() {
	let attributes = [NSAttributedStringKey.foregroundColor: ColorUtility().blackColor, NSAttributedString.Key.font: self.getUIFontByTextStyle(textStyle: self.titleFontTextStyle)]
UINavigationBar.appearance().titleTextAttributes = attributes
}

}