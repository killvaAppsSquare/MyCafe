//
//  ExtensionsClass.swift
//  Elmla3eb
//
//  Created by Macbook Pro on 4/12/17.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation
import UIKit
extension String {
    
    var doesNOTcontainSpecialCharacters : Bool {  
        
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@.١٢٣٤٥٦٧٨٩٠ضصثقفغعهخحجةشسيبلاتنمكظطذدزرو")
        if self.rangeOfCharacter(from: characterset.inverted) != nil {
//            print("string contains special characters")
            return false
        }else {
            return true
        }
    }
    
    var ispriceValue : Bool {
        
        let characterset = CharacterSet(charactersIn: "1234567890٠١٢٣٤٥٦٧٨٩")
        if self.rangeOfCharacter(from: characterset.inverted) != nil {
//            print("string contains special characters")
            return false
        }else {
            return true
        }
    }
    //let pattern = "^(009665|9665|\\+9665|05|5)?(5|0|3|6|4|9|1|8|7)([0-9]{7})$"
//    func validate(value: String) -> Bool {
//        let PHONE_REGEX = "^(009665|9665|\\+9665|05|5)?(5|0|3|6|4|9|1|8|7)([0-9]{7})$"
//        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
//        let result =  phoneTest.evaluate(with: value)
//        return result
//    }

    
    var validPhoneNumber : Bool  {
//        print("that is the phone : \(self)")
        let PHONE_REGEX = "^(01)?(0|1|2)([0-9]{10})$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: self)
//        print("that is the phone result : \(result)")
        return result

    }
//012  215 153 24
    
    //To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    
    //Validate Email
    
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }
    
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    
    //validate Password
    var isValidPassword: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z_0-9\\-_,;.:#+*?=!§$%&/()@]+$", options: .caseInsensitive)
            if(regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil){
                
                if(self.characters.count>=4 && self.characters.count<=20){
                    return true
                }else{
                    return false
                }
            }else{
                return false
            }
        } catch {
            return false
        }
    }
    
    var  isValidCount  : Bool {
            if(self.characters.count>=8 && self.characters.count<=20){
                return true
            }else{
                return false
            }
    }
    
}

import CDAlertView
extension UIView {
    func showAlert(_ title : String? , _ sms : String? ,_ alertType : CDAlertViewType ,_ action:( ()->())?) {
        
 
        let alert = CDAlertView(title: title, message: sms, type: alertType)
        alert.hideAnimations = { (center, transform, alpha) in
            transform = CGAffineTransform(scaleX: 3, y: 3)
            transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 90 ) / 180 )
            alpha = 0
            action?()
        }
        alert.hideAnimationDuration = 0.55
        alert.show()
    }
    
    func showSimpleAlert(_ title : String? , _ sms : String? ,_ alertType : CDAlertViewType ) {
        
        let alert = CDAlertView(title: title, message: sms, type: alertType)
        alert.hideAnimations = { (center, transform, alpha) in
            transform = CGAffineTransform(scaleX: 3, y: 3)
            transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 90 ) / 180 )
            alpha = 0
        }
        alert.hideAnimationDuration = 0.55
        alert.show()
    }
    
    func emptyTextFieldHandler(_ textF : UITextField,_ title : String,_ sms : String?,_ alertTyper : CDAlertViewType) {
         self.showAlert(title, sms, alertTyper, {
            
//            textF.becomeFirstResponder()
        })
    }
}

//extension UIImageView {
//    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
//        contentMode = mode
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
//                let data = data, error == nil,
//                let image = UIImage(data: data)
//                else { return }
//            DispatchQueue.main.async() { () -> Void in
//                self.image = image
//            }
//            }.resume()
//    }
//    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
//        guard let url = URL(string: link) else { return }
//        downloadedFrom(url: url, contentMode: mode)
//    }
//}



extension UIColor {
    
   public class  var lightRed : UIColor {
        return UIColor(red: 180/255, green: 32/255, blue: 36/255, alpha: 1)
    }
   public class   var darkRed : UIColor {
        return UIColor(red: 90/255, green: 30/255, blue: 24/255, alpha: 1)
    }
}

extension Array {
    mutating func remove(at indexes: [Int]) {
        for index in indexes.sorted(by: >) {
            remove(at: index)
        }
    }
}
extension String {
    
    
}

//
//public enum ImageFormat {
//    case png
//    case jpeg(CGFloat)
//}
//
//extension UIImage {
//    
//    public func base64(format: ImageFormat) -> String? {
//        var imageData: Data?
//        switch format {
//        case .png: imageData = UIImagePNGRepresentation(self)
//        case .jpeg(let compression): imageData = UIImageJPEGRepresentation(self, compression)
//        }
//        return imageData?.base64EncodedString()
//    }
//}
//
//
//
//extension UIImageView {
//    
//    func setRounded() {
//        let radius = self.bounds.width / 2
//        self.layer.cornerRadius = radius
//        self.layer.masksToBounds = true
//    }
//}
//
//
//
//
//
//
//extension UIImage {
//    var base64EncodedString: String? {
//        if let data = UIImagePNGRepresentation(self) {
//            //            let dataStr = data.base64EncodedString(options: [])
//            
//            return data.base64EncodedString(options: [.lineLength64Characters])
//        }
//        return nil
//    }
//}
//
//
//extension UIImage {
//    func resized(withPercentage percentage: CGFloat) -> UIImage? {
//        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
//        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
//        defer { UIGraphicsEndImageContext() }
//        draw(in: CGRect(origin: .zero, size: canvasSize))
//        return UIGraphicsGetImageFromCurrentImageContext()
//    }
//    func resized(toWidth width: CGFloat) -> UIImage? {
//        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
//        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
//        defer { UIGraphicsEndImageContext() }
//        draw(in: CGRect(origin: .zero, size: canvasSize))
//        return UIGraphicsGetImageFromCurrentImageContext()
//    }
//    
//    
//    
//    func resizeImageWith(newSize: CGSize) -> UIImage {
//        
//        let horizontalRatio = newSize.width / size.width
//        let verticalRatio = newSize.height / size.height
//        
//        let ratio = max(horizontalRatio, verticalRatio)
//        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
//        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
//        draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return newImage!
//    }
//    
//}


extension UIViewController {
    
    func setBackButton(){
        
        let yourBackImage = UIImage(named: "backBtn")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
    }
}

