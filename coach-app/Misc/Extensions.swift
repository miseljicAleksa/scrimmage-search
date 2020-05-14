//
//  Extensions.swift
//  coachingApp
//
//  Created by alk msljc on 10/24/19.
//  Copyright © 2019 alk msljc. All rights reserved.
//


import Foundation
import UIKit
import CommonCrypto
import SideMenuSwift

@IBDesignable extension UIView {
    func viewBorderBottom() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 0.25
        self.layer.shadowRadius = 0.0
    }
    
    func setBorder() {
        //self.layer.borderColor = UIColor.black.cgColor
        //self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
    
     @IBInspectable
     var viewBorderWidth: CGFloat {
       get {
         return layer.borderWidth
       }
       set {
         layer.borderWidth = newValue
       }
     }
     
     @IBInspectable
     var viewBorderColor: UIColor? {
       get {
         if let color = layer.borderColor {
           return UIColor(cgColor: color)
         }
         return nil
       }
       set {
         if let color = newValue {
           layer.borderColor = color.cgColor
         } else {
           layer.borderColor = nil
         }
       }
     }
    
}

extension UIFont {
    private static func coachHeadline(name: String = "HelveticaNeue-Bold", size: CGFloat = 20) -> UIFont {
        let font = UIFont(name: name, size: size)
        assert(font != nil, "Can't load font: \(name)")
        return font ?? UIFont.systemFont(ofSize: size)
    }
    
    private static func coachParagraph(name: String, size: CGFloat = 12) -> UIFont {
        let font = UIFont(name: name, size: size)
        assert(font != nil, "Can't load font: \(name)")
        return font ?? UIFont.systemFont(ofSize: size)
    }
    

}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}

extension String {
    var localized: String {
        return self
    }
    var length: Int {
        return count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}


extension UIColor {
    static func coachGreen() -> UIColor{
        return UIColor(red: 58/225, green: 201/225, blue: 32/225, alpha: 1)
    }
    
    static func coachGrey() -> UIColor{
        return UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
    }
}


extension UIImage {
    func tinted(with color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        color.set()
        withRenderingMode(.alwaysTemplate)
            .draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

extension UITextField {
    //Add underline to forms
    func underlined(){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        border.bounds = CGRect(x: 0, y: 0, width:  self.frame.size.width, height: self.frame.size.height)
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    func setTetxFieldDisabled()
    {
        self.tintColor = UIColor.clear
        self.isUserInteractionEnabled = false
    }
 
        @IBInspectable var scrimmageBackground: Bool {
            get {
                return self.scrimmageBackground
            }
            set {
                let border = CALayer()
                let width = CGFloat(1.0)
                let color:UIColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 0.9)
                border.borderColor = color.cgColor
                border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
                border.borderWidth = width
                border.bounds = CGRect(x: 0, y: 0, width:  self.frame.size.width, height: self.frame.size.height)
                self.layer.addSublayer(border)
                self.layer.masksToBounds = true
                self.backgroundColor = color
            }
        }
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            
        }
    }
}

extension UILabel {
    
    func approved(){
        self.textColor = UIColor.white
        self.layer.borderColor = UIColor(red: 156/255, green: 217/255, blue: 160/255, alpha: 1).cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 3
        self.backgroundColor = UIColor(red: 126/255, green: 194/255, blue: 130/255, alpha: 1)
        self.layer.masksToBounds = true
    }
    func pending(){
        self.textColor = UIColor.white
        self.layer.borderColor = UIColor(red: 219/255, green: 218/255, blue: 171/255, alpha: 1).cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 3
        self.backgroundColor = UIColor(red: 214/255, green: 213/255, blue: 139/255, alpha: 1)
        self.layer.masksToBounds = true
    }
    func canceled(){
        self.textColor = UIColor.white
        self.layer.borderColor = UIColor(red: 219/255, green: 172/255, blue: 171/255, alpha: 1).cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 3
        self.backgroundColor = UIColor(red: 204/255, green: 144/255, blue: 143/255, alpha: 1)
        self.layer.masksToBounds = true
    }
    
    func paid(){
        self.textColor = UIColor.white
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor(red: 126/255, green: 194/255, blue: 130/255, alpha: 1)
        self.layer.masksToBounds = true
    }
    func issued(){
        self.textColor = UIColor.white
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor(red: 214/255, green: 213/255, blue: 139/255, alpha: 1)
        self.layer.masksToBounds = true
    }
    func storno(){
        self.textColor = UIColor.white
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor(red: 204/255, green: 144/255, blue: 143/255, alpha: 1)
        self.layer.masksToBounds = true
    }
    
    
    func paidText(){
        self.textColor = UIColor.green
    }
    func issuedText(){
        self.textColor = UIColor.yellow
    }
    func stornoText(){
        self.textColor = UIColor.red
    }
    
    // Pass value for any one of both parameters and see result
      func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {

          guard let labelText = self.text else { return }

          let paragraphStyle = NSMutableParagraphStyle()
          paragraphStyle.lineSpacing = lineSpacing
          paragraphStyle.lineHeightMultiple = lineHeightMultiple

          let attributedString:NSMutableAttributedString
          if let labelattributedText = self.attributedText {
              attributedString = NSMutableAttributedString(attributedString: labelattributedText)
          } else {
              attributedString = NSMutableAttributedString(string: labelText)
          }

          // Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

          self.attributedText = attributedString
      }
    
    
    
}

extension UIImageView {
    
    func downloadCompletion(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill, completion:@escaping (_ status: Data?) -> Void) {
        
        guard let url = URL(string: link) else {return}
        
        contentMode = mode
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil
                
                else {
                    return
            }
            completion(data)
            }.resume()
    }
    
    
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    DispatchQueue.main.sync {
                        self.image = UIImage(named: "ic_launcher_web.png")
                    }
                    return
            }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        self.image = UIImage(named: "lagreeFitness")
        guard let url = URL(string: link) else {return}
        downloadedFrom(url: url, contentMode: mode)
    }
    
    func setRounded() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.clear.cgColor
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height/2
    }
    
    func setRoundedBorder() {
        let imageViewWhite = UIImageView(frame: CGRect(x: self.frame.minX-2, y: self.frame.minY-2, width: self.bounds.width+4, height: self.bounds.height+4))
        imageViewWhite.contentMode = .scaleAspectFill
        imageViewWhite.setRounded()
        imageViewWhite.backgroundColor = UIColor.white
        self.superview?.addSubview(imageViewWhite)
        self.superview?.addSubview(self)
        self.setRounded()
    }
}

@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}


@IBDesignable extension UIView {
    
    @IBInspectable var coachGreyColor: UIColor? {
        set {
            let uiColor = UIColor.coachGrey()
            self.backgroundColor = uiColor
        }
        get {
            guard let color = self.backgroundColor else { return nil }
            return UIColor(cgColor: color.cgColor)
        }
    }
}

extension UIButton{
    
    func setRounded(rad: CGFloat = 10){
        self.layer.cornerRadius = rad
    }
    
    func setRoundedBorder(rad: CGFloat = 5){
        self.layer.cornerRadius = rad
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    func addTextSpacing(spacing: CGFloat){
        let attributedString = NSMutableAttributedString(string: (self.titleLabel?.text!)!)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSRange(location: 0, length: (self.titleLabel?.text!.count)!))
        self.setAttributedTitle(attributedString, for: .normal)
    }
    
    func setLagreeRedColor(){
        
        self.backgroundColor = UIColor.coachGreen()
    }
    
    func startAnimating() {
        
        let indicator = UIActivityIndicatorView()
        indicator.color = UIColor.black
        indicator.hidesWhenStopped = true
        let buttonHeight = self.bounds.size.height
        //let buttonWidth = self.bounds.size.width
        indicator.center = CGPoint(x: 30, y: buttonHeight/2)
        self.addSubview(indicator)
        indicator.startAnimating()
        
    }
    
    func stopAnimating() {
        
        for view in self.subviews {
            if let indicator = view as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
       
    }
}

// 1
private var maxLengths = [UITextField: Int]()

// 2
extension UITextField {
    
    // 3
    @IBInspectable var maxLength: Int {
        get {
            // 4
            guard let length = maxLengths[self] else {
                return Int.max
            }
            return length
        }
        set {
            maxLengths[self] = newValue
            // 5
            addTarget(
                self,
                action: #selector(limitLength),
                for: UIControl.Event.editingChanged
            )
        }
    }
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
    
    @objc func limitLength(textField: UITextField) {
        // 6
        guard let prospectiveText = textField.text, prospectiveText.count > maxLength else {
            return
        }
        
        let selection = selectedTextRange
        // 7
        text = prospectiveText.substring(with:
            prospectiveText.startIndex ..< prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength))
        selectedTextRange = selection
    }
    
    func borderBottom() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 0.0
    }
    
}

extension UIImage {
    func resizeImage(_ width: CGFloat) -> UIImage? {
        
        let aspectRatio = size.width / size.height
        let height = width * aspectRatio
        let newSize = CGSize(width: width, height: height)
        func scaleImage(_ newSize: CGSize) -> UIImage? {
            func getScaledRect(_ newSize: CGSize) -> CGRect {
                let ratio   = max(newSize.width / size.width, newSize.height / size.height)
                let width   = size.width * ratio
                let height  = size.height * ratio
                return CGRect(x: 0, y: 0, width: width, height: height)
            }
            
            func _scaleImage(_ scaledRect: CGRect) -> UIImage? {
                UIGraphicsBeginImageContextWithOptions(scaledRect.size, false, 0.0);
                draw(in: scaledRect)
                let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
                UIGraphicsEndImageContext()
                return image
            }
            return _scaleImage(getScaledRect(newSize))
        }
        
        return scaleImage(newSize)!
    }
}

extension String {
    func roundNumeric() -> String {
        if(Double(self) != nil){
            let dbl = (Double(self)! * 100).rounded() / 100
            return String(format:"%.2f", dbl);
        }else{
            return "0.00"
        }
    }
    func toDouble() -> Double {
        if(Double(self) != nil){
            let dbl = (Double(self)! * 100).rounded() / 100
            return dbl
        }else{
            return 0.00
        }
    }
    
    func toOneDecimal() -> String {
           if(Double(self) != nil){
               return String(format:"%.1f", Double(self)!);
           }else{
               return "0"
           }
       }
    
    func toDate() -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
        if let date = dateFormatter.date(from: self) //according to date format your date string
        {
            return date
        }
        return Date()
    }
    
    func toDateTime() -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
        if let date = dateFormatter.date(from: self) //according to date format your date string
        {
            return date
        }
        return Date()
    }
    
    func setStrikethrough(color:UIColor = UIColor.red) -> NSAttributedString  {
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.strikethroughColor, value: color, range: NSMakeRange(0, attributedString.length))
        return attributedString
    }
    
    func HMACsha256(key: String) -> String {
        let inputData: NSData = self.data(using: String.Encoding.utf8, allowLossyConversion: false)! as NSData
        let keyData: NSData = key.data(using: String.Encoding.utf8, allowLossyConversion: false)! as NSData
        
        let digestLen = Int(CC_SHA256_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256), keyData.bytes, keyData.length, inputData.bytes, inputData.length, result)
        let data = NSData(bytes: result, length: digestLen)
        //I am not sure if  >> deinitialize(count: digestLen) << will solve problem
        result.deinitialize(count: digestLen)
        return data.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
    }
    
    func md5() -> String? {
        guard let messageData = self.data(using:String.Encoding.utf8) else { return nil }
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        return String(data: digestData, encoding: String.Encoding.utf8) as String?
    }
    //phone call
    enum RegularExpressions: String {
        case phone = "^\\s*(?:\\+?(\\d{1,3}))?([-. (]*(\\d{3})[-. )]*)?((\\d{3})[-. ]*(\\d{2,4})(?:[-.x ]*(\\d+))?)\\s*$"
    }
    
    func isValid(regex: RegularExpressions) -> Bool {
        return isValid(regex: regex.rawValue)
    }
    
    func isValid(regex: String) -> Bool {
        let matches = range(of: regex, options: .regularExpression)
        return matches != nil
    }
    
    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter{CharacterSet.decimalDigits.contains($0)}
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }
    
    func makeACall() {
        if isValid(regex: .phone) {
            if let url = URL(string: "tel://\(self.onlyDigits())"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
}

extension UITableView {

    func scrollToBottom(animated: Bool) {
        var y: CGFloat = 0.0
        let HEIGHT = self.frame.size.height
        if self.contentSize.height > HEIGHT {
            y = self.contentSize.height - HEIGHT
        }
        self.setContentOffset(CGPoint(x: 0, y: y), animated: animated)
    }
    
}
extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    var string: String {
        return String(format: "%.2f",self)
    }
    
    var stringWithoutDecimal: String {
        return String(format: "%.0f", self)
    }
}

extension UIToolbar {
    
    func ToolbarPiker(doneSelector : Selector, cancelSelector : Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: doneSelector)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: cancelSelector)
        
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
}

extension Date {
    
    var formatted: String {
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy, HH:mm"
        //df.locale = Locale(identifier: "en_US_POSIX")
        return df.string(from: self as Date)
    }
    
    var dayMonth: String {
        let df = DateFormatter()
        df.dateFormat = "MMM, dd"
        //df.locale = Locale(identifier: "en_US_POSIX")
        return df.string(from: self as Date)
    }
    
    var dayNameMonth: String {
        let df = DateFormatter()
        df.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        df.dateFormat = "EEEE, dd"
        //df.locale = Locale(identifier: "en_US_POSIX")
        return df.string(from: self as Date)
    }
    
    var year: String {
        let df = DateFormatter()
        df.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        df.dateFormat = "yyyy"
        //df.locale = Locale(identifier: "en_US_POSIX")
        return df.string(from: self as Date)
    }
    
    var monthAndDay: String {
        let df = DateFormatter()
        df.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        df.dateFormat = "MM/dd, HH:mm"
        //df.locale = Locale(identifier: "en_US_POSIX")
        return df.string(from: self as Date)
    }
    
    var dayName: String {
        let df = DateFormatter()
        df.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        df.dateFormat = "EEEE"
        //df.locale = Locale(identifier: "en_US_POSIX")
        return df.string(from: self as Date)
    }
    
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        let diff = Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
        let res: Double = round(Double(diff)/24.0)
        return Int(res)
    }
    
    /// Returns easyReadable date
    var easyReadable: String {
        let date = Date()
        print(self.formatted)
        print(days(from: date))
        if days(from: date)  == -1 { return "Yesterday".localized    }
        if days(from: date)  == 0 { return "Today".localized    }
        if days(from: date)  == 1 { return "Tomorrow".localized   }
        if days(from: date)  < 5 { return self.dayNameMonth  }
        return self.dayMonth
    }
    
    func getDayDiff(toDate: Date) -> Int
    {
        let calendar = NSCalendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: self)
        let date2 = calendar.startOfDay(for: toDate)
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day ?? 0
    }
    
    func timeAgo() -> String {

        // From Time
        let fromDate = self

        // To Time
        let toDate = Date()

        // Estimation
        // Year
        if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {

            return interval == 1 ? "\(interval)" + " " + "year ago" : "\(interval)" + " " + "years ago"
        }

        // Month
        if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {

            return interval == 1 ? "\(interval)" + " " + "month ago" : "\(interval)" + " " + "months ago"
        }

        // Day
        if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {

            return interval == 1 ? "\(interval)" + " " + "day ago" : "\(interval)" + " " + "days ago"
        }

        // Hours
        if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {

            return interval == 1 ? "\(interval)" + " " + "hour ago" : "\(interval)" + " " + "hours ago"
        }

        // Minute
        if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {

            return interval == 1 ? "\(interval)" + " " + "minute ago" : "\(interval)" + " " + "minutes ago"
        }

        return "a moment ago"
    }
}





extension UIViewController {
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: 10, y: self.view.frame.size.height/2-15, width: self.view.frame.size.width-20, height: 30))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: toastLabel.font.fontName, size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.adjustsFontSizeToFitWidth = true
        toastLabel.layer.cornerRadius = 3;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 2.0, delay: 3, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    
}


extension UINavigationItem {
    
    func setTitle(_ title: String, subtitle: String) {
        let appearance = UINavigationBar.appearance()
        let textColor = appearance.titleTextAttributes?[NSAttributedString.Key.foregroundColor] as? UIColor ?? .black
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .preferredFont(forTextStyle: UIFont.TextStyle.headline)
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = textColor
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = .preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
        subtitleLabel.font = UIFont.boldSystemFont(ofSize: 11)
        // hex 9D9A7E
        // 8A8870
        subtitleLabel.textColor = UIColor(red:0.54, green:0.53, blue:0.44, alpha:1.0)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = -5.0
        
        self.titleView = stackView
    }
}
extension UIApplication {
    
    static func topViewController(base: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
}

//Declare enum
enum AnimationType{
    case ANIMATE_RIGHT
    case ANIMATE_LEFT
    case ANIMATE_UP
    case ANIMATE_DOWN
    case ANIMATE_DISSOLVE
}

extension Date {

    func timeAgoSinceDate() -> String {

        // From Time
        let fromDate = self

        // To Time
        let toDate = Date()

        // Estimation
        // Year
        if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {

            return interval == 1 ? "\(interval)" + " " + "year ago" : "\(interval)" + " " + "years ago"
        }

        // Month
        if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {

            return interval == 1 ? "\(interval)" + " " + "month ago" : "\(interval)" + " " + "months ago"
        }

        // Day
        if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {

            return interval == 1 ? "\(interval)" + " " + "day ago" : "\(interval)" + " " + "days ago"
        }

        // Hours
        if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {

            return interval == 1 ? "\(interval)" + " " + "hour ago" : "\(interval)" + " " + "hours ago"
        }

        // Minute
        if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {

            return interval == 1 ? "\(interval)" + " " + "minute ago" : "\(interval)" + " " + "minutes ago"
        }

        return "a moment ago"
    }
}

// Create Function...
extension UIWindow {
    func showViewControllerWith(withIdentifier:String, usingAnimation animationType:AnimationType, menu:Bool = true )
    {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var newViewController = storyboard.instantiateViewController(withIdentifier: withIdentifier)
        newViewController = UINavigationController(rootViewController: newViewController)
        let currentViewController = self.rootViewController
        let width = currentViewController?.view.frame.size.width;
        let height = currentViewController?.view.frame.size.height;
        
        var previousFrame:CGRect?
        var nextFrame:CGRect?
        
        switch animationType
        {
        case .ANIMATE_LEFT:
            previousFrame = CGRect(x:width!-1, y:0.0, width:width!, height:height!)
            nextFrame = CGRect(x:-width!, y:0.0, width:width!, height:height!);
        case .ANIMATE_RIGHT:
            previousFrame = CGRect(x:-width!+1, y:0.0, width:width!, height:height!);
            nextFrame = CGRect(x:width!, y:0.0, width:width!, height:height!);
        case .ANIMATE_UP:
            previousFrame = CGRect(x:0.0, y:height!-1, width:width!, height:height!);
            nextFrame = CGRect(x:0.0, y:-height!+1, width:width!, height:height!);
        case .ANIMATE_DOWN:
            previousFrame = CGRect(x:0.0, y:-height!+1, width:width!, height:height!);
            nextFrame = CGRect(x:0.0, y:height!-1, width:width!, height:height!);
        case .ANIMATE_DISSOLVE:
            newViewController.view.frame = (currentViewController?.view.frame)!
            newViewController.view.layoutIfNeeded()
            
            UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.rootViewController = newViewController
            }, completion: { completed in
                // maybe do something here
            })
            return
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        newViewController.view.frame = previousFrame!
        UIApplication.shared.delegate?.window??.addSubview(newViewController.view)
        UIView.animate(withDuration:0.5,
                       animations: { () -> Void in
                        newViewController.view.frame = (currentViewController?.view.frame)!
                        currentViewController?.view.frame = nextFrame!
                        
        })
        { (fihish:Bool) -> Void in
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

            //var window = appDelegate.window!
            
            
            let menuViewController: UIViewController = LeftMenuController()
            if menu{
                let screenWidth = UIScreen.main.bounds.size.width
                SideMenuController.preferences.basic.menuWidth = screenWidth / 5 * 4
                SideMenuController.preferences.basic.statusBarBehavior = .hideOnMenu
                SideMenuController.preferences.basic.direction = .left
                SideMenuController.preferences.basic.enablePanGesture = true
                let sideMenuController = SideMenuController(contentViewController: newViewController , menuViewController: menuViewController)

                let window = UIWindow(frame: UIScreen.main.bounds)
                window.rootViewController = sideMenuController
                window.makeKeyAndVisible()
                
            }else{
//            UIApplication.shared.windows.first.rootViewController = newViewController
                appDelegate.window!.rootViewController = newViewController
                       UIApplication.shared.windows.first?.makeKeyAndVisible()
            }
        }
    }
}
extension UIRefreshControl {
    func refreshManually(tableView: UITableView) {
        
        tableView.setContentOffset(CGPoint(x: 0, y: tableView.contentOffset.y - frame.height), animated: true)
        
        beginRefreshing()
        sendActions(for: .valueChanged)
    }
    
}
extension UIView {

    @IBInspectable
    var cornersOfView: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
     /**
      Rounds the given set of corners to the specified radius

      - parameter corners: Corners to round
      - parameter radius:  Radius to round to
      */
     func round(corners: UIRectCorner, radius: CGFloat) {
         _ = _round(corners: corners, radius: radius)
     }

     /**
      Rounds the given set of corners to the specified radius with a border

      - parameter corners:     Corners to round
      - parameter radius:      Radius to round to
      - parameter borderColor: The border color
      - parameter borderWidth: The border width
      */
     func round(corners: UIRectCorner, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
         let mask = _round(corners: corners, radius: radius)
         addBorder(mask: mask, borderColor: borderColor, borderWidth: borderWidth)
     }

     /**
      Fully rounds an autolayout view (e.g. one with no known frame) with the given diameter and border

      - parameter diameter:    The view's diameter
      - parameter borderColor: The border color
      - parameter borderWidth: The border width
      */
     func fullyRound(diameter: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
         layer.masksToBounds = true
         layer.cornerRadius = diameter / 2
         layer.borderWidth = borderWidth
         layer.borderColor = borderColor.cgColor;
     }

 }

 private extension UIView {

     @discardableResult func _round(corners: UIRectCorner, radius: CGFloat) -> CAShapeLayer {
         let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
         return mask
     }

func addBorder(mask: CAShapeLayer, borderColor: UIColor, borderWidth: CGFloat) {
    let borderLayer = CAShapeLayer()
    borderLayer.path = mask.path
    borderLayer.fillColor = UIColor.clear.cgColor
    borderLayer.strokeColor = borderColor.cgColor
    borderLayer.lineWidth = borderWidth
    borderLayer.frame = bounds
    layer.addSublayer(borderLayer)
}
}

extension UIImage {
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        let imageString = imageData.base64EncodedString()
        return imageString
    }
}

extension UIBarButtonItem {

    static func menuButton(_ target: Any?, action: Selector, imageName: String) -> UIBarButtonItem {
        let button = UIButton(type: .roundedRect)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true

        return menuBarItem
    }
    
}
extension UIViewController{

    func traverseAndFindClass<T : UIViewController>() -> T? {
        var currentVC = self
        while let parentVC = currentVC.parent {
            if let result = parentVC as? T {
                return result
            }
            currentVC = parentVC
        }
        return nil
    }
    
}
extension Array {
    func firstMatchingType<Type>() -> Type? {
        return first(where: { $0 is Type }) as? Type
    }
}
 
