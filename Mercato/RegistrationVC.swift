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

class RegistrationVC: UIViewController {

    @IBOutlet weak var confirmPassTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var mobileNumTxt: UITextField!
    @IBOutlet weak var fullnameTxt: UITextField!
    @IBOutlet weak var birthdayText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
setupPickerV() 
setupTextsDelegate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func sendData() {
        
        guard let name =  fullnameTxt.text ,let phone =  mobileNumTxt.text ,let email =  emailTxt.text ,let pass =  passTxt.text ,let conPass =  confirmPassTxt.text ,let birthdate =  birthdayText.text ,  else { return }
//        let dataM = MUserData()
//        dataM.postRegiserationData(email: <#T##String#>, userPassword: <#T##String#>, name: <#T##String#>, birthday: <#T##String#>, phone_number: <#T##String#>, completed: <#T##((PostLoginVars?, Bool, String, [String : Any]?, String)) -> ()#>)
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
extension RegistrationVC :  UIPickerViewDelegate,UITextFieldDelegate {
    
    func setupTextsDelegate() {
        
        let textsF = [confirmPassTxt,emailTxt,mobileNumTxt,fullnameTxt,passTxt]
        
        for txt in textsF {
            txt?.delegate = self
        }
    }
    
   
    func textFieldDidEndEditing(_ textField: UITextField) {
        if   textField == birthdayText ,  textField.text == "" {
            let formatter = DateFormatter()
            let date_ = Calendar.current.date(byAdding: .year, value: -10, to: Date())
            formatter.dateFormat =   "yyyy-MM-dd"
            guard let date = date_ else { return }
            let dateS  = formatter.string(from: date )
            textField.text = dateS
            
        }
        switch textField {
         case mobileNumTxt :
             if let txt =  mobileNumTxt.text , txt.validPhoneNumber {
                print(("√"))

            }else {
                print(("X"))
            }
        case emailTxt :
            if let txt =  emailTxt.text , txt.isEmail {
                print(("√"))
                
            }else {
                print(("X"))
            }
        case confirmPassTxt :
            if passTxt.text != confirmPassTxt.text {
                print("really Dude!!!")
                self.view.showAlert("Password not Matched!!", "Please Confirm your password", { 
                    
                    self.confirmPassTxt.becomeFirstResponder()
                })
            }else {
                print(" √")
            }
        default:
            break
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == birthdayText  {
            
            
            let datePicker = UIDatePicker()
            datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -10, to: Date())
            datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -90, to: Date())
            
            //            let secondsInMonth: TimeInterval = 360 * 24 * 60 * 60
            //            datePicker.maximumDate = Date(timeInterval: secondsInMonth, since: Date())
            
            datePicker.datePickerMode = UIDatePickerMode.date
            textField.inputView = datePicker
            datePicker.addTarget(self, action: #selector(self.timePickerChanged(_:)), for: .valueChanged)
        }
        
             if textField == confirmPassTxt , let txt = passTxt.text, txt.isBlank{
                print("really Dude!!!")
            }
       
    }
    
    
    //Picker
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func setupPickerV() {
        birthdayText.delegate = self
    }
    
    
    
    
    func timePickerChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        birthdayText.text = formatter.string(from: sender.date)
    }
    
    
    
}
