import UIKit

extension UIView {
    //function to transform a view in UIImage
    func toImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
     }
}

// function to shared a screen shot about the statement
func sharedView(view: UIView, viewController: UIViewController) {
    let imageToShare = [view.toImage()]
    let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
    activityViewController.popoverPresentationController?.sourceView = view
    viewController.present(activityViewController, animated: true, completion: nil)
}

// function to convert hexa color in uicolor
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

// function to transform an int number to a string valid value
func formatAmount(amount: Int) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.groupingSeparator = "."
    numberFormatter.groupingSize = 3
    numberFormatter.usesGroupingSeparator = true
    numberFormatter.decimalSeparator = ","
    numberFormatter.numberStyle = .decimal
    numberFormatter.maximumFractionDigits = 2
    return numberFormatter.string(from: amount as NSNumber)!
}

// function to return a formated description
func getTitle(title: String) -> String {
    switch title {
    case "pixcashin".uppercased():
        return "Transferência PIX recebida"
    case "pixcashout".uppercased():
        return "Transferência PIX enviada"
    case "bankslipcashin".uppercased():
        return "Depósito por boleto"
    case "transferin".uppercased():
        return "Transferência recebida"
    case "transferout".uppercased():
        return "Transferência enviada"
    default:
        return "Transferência"
    }
}

// function to convert string to date, change it's format then return a string
func getDate(data: String,formart: String, newFormat: String) -> String {
    let dateFormatter = DateFormatter()
    let newDateFormatter = DateFormatter()
    dateFormatter.dateFormat = formart
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    let date = dateFormatter.date(from:data) ?? Date()
    newDateFormatter.dateFormat = newFormat
    return newDateFormatter.string(from: date)
}
