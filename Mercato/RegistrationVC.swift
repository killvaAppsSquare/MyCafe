//
//  RegistrationVC.swift
//  Mercato
//
//  Created by Macbook Pro on 8/14/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit
import TextFieldEffects
import CDAlertView

protocol RegisterToLoginProtocol : class {/// Navigate to Addreview
    
    func sendSignalToAllReview(_ isNav : Bool)
}
class RegistrationVC: UIViewConWithLoadingIndicator {
    
    @IBOutlet weak var confirmPassTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var mobileNumTxt: UITextField!
    @IBOutlet weak var fullnameTxt: UITextField!
    @IBOutlet weak var birthdayText: UITextField!
    @IBOutlet weak var modelViewNavBarHeight: NSLayoutConstraint!
    
 
    
    
    
    var nukeTf = false
    weak var delegate : RegisterToLoginProtocol?
    var isModelView = false
    
    var serialNum = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
           title = "Registration"
        modelViewNavBarHeight.constant = isModelView ? 64 : 0
        setupPickerV()
        setupTextsDelegate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        nukeTf = true
    }
    
    @IBAction func registerAction(_ sender: UIButtonX) {
        
        sendData()
    }
    
    
    func sendData() {
        
        self.view.endEditing(true)
        textFieldValidation()
        
        
    }
    
    @IBAction func modelViewDismissBtn(_ sender: UIButtonX) {
        if let y =  self.presentingViewController?.presentingViewController {
            //            print("YOYOOY 2 Views ")
            y.dismiss(animated: true, completion: nil)
        }
    }
    //TEST REGISTER WITH OUT VALIDATION
//    func textFieldValidation() {
//        self.loading()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3.1) {
//            self.killLoading()
//            self.handleRegisterSuccess()
////            self.view.showSimpleAlert("Success", "Welcome", .success)
////            self.handleRegisterSuccess()
//        }
//    }
    func textFieldValidation() {

        let tfBundle : [(UITextField , String)] = [(fullnameTxt,"Full Name"),(mobileNumTxt,"Mobile Number"),(birthdayText,"Birthdate"),(emailTxt,"Email"),(passTxt,"Password"),(confirmPassTxt,"Confirm Password")]
        
        var counter = 0
        for (txt , alertSms) in tfBundle {
            print(txt , alertSms)
            if let valid = txt.text , valid.isBlank  /*, txt != fullnameTxt , txt != mobileNumTxt*/ {
                view.showAlert("", "\(alertSms) is Required", .warning, {
                    txt.becomeFirstResponder()
                })
                return
            }
            let isValid =  textFieldRulesValidation(txt)
            guard isValid else {
                return }
            counter += 1
        }
        
        if counter == 6 {
            let dataM = MUserData()
            self.loading()
            dataM.postRegiserationData(name: fullnameTxt.text, phone_number: mobileNumTxt.text, email: emailTxt.text, userPassword: passTxt.text, birthday: birthdayText.text,serialNum :serialNum) { [weak self ](data) in
                
                if data.0 , let id = data.1{
                    ad.saveUserLogginData(email: nil, photoUrl: nil, uid: id, name: nil)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                        self?.view.showSimpleAlert("Success", "Welcome", .success)
                        self?.handleRegisterSuccess()
                        self?.killLoading()
                    }
                    
                }else {
                    DispatchQueue.main.async {
                        self?.view.showSimpleAlert("Failed ot register!!", "Please try again", .error)
                        self?.killLoading()
                    }
                }
                
            }
        }
        
        
    }
    
    func handleRegisterSuccess() {

        guard isModelView else {
            
//              navigationController?.popToRootViewController(animated: true)
            navigationController?.popViewController(animated: true)
            self.delegate?.sendSignalToAllReview(true)
            return
        }
        
        self.presentingViewController?.dismiss(animated: true) { [weak self ] (true) in
            
            self?.delegate?.sendSignalToAllReview(false)
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
}



//MARK: PickerView
extension RegistrationVC :  UITextFieldDelegate {
    
    func setupTextsDelegate() {
        
        let textsF = [confirmPassTxt,emailTxt,mobileNumTxt,fullnameTxt,passTxt]
        
        for txt in textsF {
            txt?.delegate = self
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard !nukeTf else { return }
        
        if   textField == birthdayText ,(  textField.text == "" || textField.text == " " ){
            
            defaultDateSelection()
        }
        
    }
    
    
    
    func textFieldRulesValidation(_ textField : UITextField)-> Bool {
        switch textField {
        case fullnameTxt :
            if let txt = fullnameTxt.text , !txt.isValidCount {
                fullnameTxt.text = ""
                
                view.showAlert("Error!!", "Full name Field has to contain 8 characters at least", .warning, {
                    self.fullnameTxt.becomeFirstResponder()
                    
                })
                return false
            }
        case mobileNumTxt :
            if let txt =  mobileNumTxt.text , !txt.validPhoneNumber {
                mobileNumTxt.text = ""
                view.showAlert("Error!!", "invalid phone Number", .warning, {
                })
                return false
            }
        case emailTxt :
            if let txt =  emailTxt.text , !txt.isEmail {
                emailTxt.text = ""
                view.showAlert("Error!!", "That's not an Email address Format", .warning, {
                })
                return false
            }
        case passTxt :
            guard  let x = passTxt.text , x.isValidPassword else {
                passTxt.text = ""
                view.showAlert("invalid Password", "Password has to contain at least 4 characters which contain no Special characters", .warning, {
                    self.passTxt.becomeFirstResponder()
                })
                return false
            }
            
        //             self.confirmPassTxt.becomeFirstResponder()
        case confirmPassTxt :
            guard let x = passTxt.text , !x.isBlank else {  return false  }
            if passTxt.text != confirmPassTxt.text {
                confirmPassTxt.text  = ""
                view.showAlert("Password Doesn't match", "please confirm your password", .warning, {
                    self.confirmPassTxt.becomeFirstResponder()
                })
                return false
            }
            
        default:
            return true
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == birthdayText  {
            
            
            
        }
        //        confirmPassTxt.isUserInteractionEnabled = true
        switch textField {
        case birthdayText:
            setupPickerForTextF()
        //        case passTxt : confirmPassTxt.isUserInteractionEnabled = false
        case confirmPassTxt :
            if textField == confirmPassTxt , let txt = passTxt.text, txt.isBlank{
                
                view.showAlert("Error!!", "Password field is Empty!!", .warning, {
                    self.passTxt.becomeFirstResponder()
                })
            }
        default:
            break
        }
        
        
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    
    
}


extension RegistrationVC : UIPickerViewDelegate {
    
    func setupPickerForTextF() {
        
        let datePicker = UIDatePicker()
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -10, to: Date())
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -90, to: Date())
        
        datePicker.datePickerMode = UIDatePickerMode.date
        birthdayText.inputView = datePicker
        datePicker.addTarget(self, action: #selector(self.timePickerChanged(_:)), for: .valueChanged)
        
    }
    func setupPickerV() {
        birthdayText.delegate = self
    }
    
    
    func defaultDateSelection() {
        
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "en")
        let date_ = Calendar.current.date(byAdding: .year, value: -20, to: Date())
        formatter.dateFormat =   "yyyy-MM-dd"
        
        guard let date = date_ else { return }
        let dateS  = formatter.string(from: date )
        birthdayText.text = dateS
        
    }
    
    func timePickerChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "en")
        formatter.dateFormat = "yyyy-MM-dd"
        birthdayText.text = formatter.string(from: sender.date)
    }
}
