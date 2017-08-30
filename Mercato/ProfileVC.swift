//
//  ProfileVC.swift
//  Mercato
//
//  Created by Macbook Pro on 8/24/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit

class ProfileVC: UIViewConWithLoadingIndicator , UITextFieldDelegate{
    
    @IBOutlet weak var fullNameTxt: UITextField!
    @IBOutlet weak var phoneNumberTxt: UITextField!
    @IBOutlet weak var birthdayTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    
    var textFields : [UITextField]!
    let mProfile = MUserData()
    var profileData : PostLoginVars?{
        didSet {
            guard let data = profileData else { return }
            DispatchQueue.main.async {
                self.fullNameTxt?.text = data.name
                self.phoneNumberTxt?.text = data.phone_number
                self.birthdayTxt?.text = data.birthday
                self.emailTxt?.text = data.email
                self.killLoading()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        textFields = [fullNameTxt,phoneNumberTxt,birthdayTxt,emailTxt]
        self.loading()
        for txt in textFields {
            txt.delegate = self
        }
        setupPickerForTextF()
        mProfile.getProfileData { [weak self ] (data, status) in
            
            guard status , let data = data  else {
                DispatchQueue.main.async {
                    self?.failedGettingData()
//                    self?.view.showSimpleAlert("Couldn't Provide Data", "Please trty again later!!", .error)
//                    self?.navigationController?.popViewController(animated: true)
                }
                return
            }
            self?.profileData = data
            
        }
        // Do any additional setup after loading the view.
    }
    
    func editableTextField(_ state : Bool){
        for txt in textFields {
            txt.isUserInteractionEnabled = state
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func btnAct(_ sender: UIButtonX) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
          title =  "Editing..."
            sender.setTitle("Save", for: .normal)
                        editableTextField(true)
              self.fullNameTxt.becomeFirstResponder()
        }else {
            self.view.endEditing(true)
            guard  checkingprofileDataBeforeSending() else { return }
            self.loading()
            mProfile.postProfileData(name: fullNameTxt.text, email: emailTxt.text, birthday: birthdayTxt.text, phone_number: phoneNumberTxt.text, completed: { [weak self ] (data, status) in
                
                guard status else {
                      DispatchQueue.main.async {
                    self?.view.showSimpleAlert("Error!!", "Something went wrong, please try again!!", .error)
                    }
                    return
                }
                DispatchQueue.main.async {
                    self?.editableTextField(false)
                    sender.setTitle("Edit", for: .normal)
                    self?.killLoading()
                    self?.title = "Profile"
                    self?.view.showSimpleAlert("Success", "", .success)
                }
            })
            
        }
    }
    
    
    func checkingprofileDataBeforeSending() -> Bool {
    
        guard let name = fullNameTxt.text , let phone = phoneNumberTxt.text, let  birthday = birthdayTxt.text,let email = emailTxt.text else { return  false }
        guard !name.isBlank , name.doesNOTcontainSpecialCharacters else {
            self.view.showSimpleAlert("Error!!", "name Shouldn't Contain Special Characters or spaces", .warning)
            return false  }
        guard !phone.isBlank , phone.validPhoneNumber else {
            self.view.showSimpleAlert("Error!!", "invalid Phone Number", .warning)
            return false  }
        guard !birthday.isBlank else {
            self.view.showSimpleAlert("Error!!", "Birthday can't be blank", .warning)
            return false  }

        guard !email.isBlank , email.isEmail else {
            self.view.showSimpleAlert("Error!!", "invalid email Format", .warning)
            return false  }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let txt = textField.text , txt.isBlank else {
            return
        }
        guard let data = profileData else { return }
        switch textField {
        case fullNameTxt: textField.text = data.name
        case phoneNumberTxt: textField.text = data.phone_number
        case birthdayTxt:  textField.text = data.birthday
        default: textField.text = data.email
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




extension ProfileVC : UIPickerViewDelegate {
    
    func setupPickerForTextF() {
        
        let datePicker = UIDatePicker()
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -10, to: Date())
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -90, to: Date())
        
        datePicker.datePickerMode = UIDatePickerMode.date
        birthdayTxt.inputView = datePicker
        datePicker.addTarget(self, action: #selector(self.timePickerChanged(_:)), for: .valueChanged)
        
    }
    func setupPickerV() {
        birthdayTxt.delegate = self
    }
    
    
    func defaultDateSelection() {
        
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "en")
        let date_ = Calendar.current.date(byAdding: .year, value: -20, to: Date())
        formatter.dateFormat =   "yyyy-MM-dd"
        
        guard let date = date_ else { return }
        let dateS  = formatter.string(from: date )
        birthdayTxt.text = dateS
        
    }
    
    func timePickerChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "en")
        formatter.dateFormat = "yyyy-MM-dd"
        birthdayTxt.text = formatter.string(from: sender.date)
    }
}
