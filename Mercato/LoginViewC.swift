//
//  LoginViewC.swift
//  Mercato
//
//  Created by Macbook Pro on 8/16/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//


import UIKit
import AVFoundation
import QRCodeReader
import CDAlertView


class LoginViewC: UIViewController , QRCodeReaderViewControllerDelegate{
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var loginBtnOL: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // Good practice: create the reader lazily to avoid cpu overload during the
    // initialization and each time we need to scan a QRCode
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode], captureDevicePosition: .back)
        }
        builder.cancelButtonTitle = "Back to Normal Loggin"
        return QRCodeReaderViewController(builder: builder)
    }()
    
    @IBAction func scanAction(_ sender: AnyObject) {
        //         Retrieve the QRCode content
        //         By using the delegate pattern
        readerVC.delegate = self
        
        // Or by using the closure pattern
        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
//            print(result)
//            print(result?.value)
            
            if result?.value == "Register" {
                let vc = RegistrationVC()
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
        
        // Presents the readerVC as modal form sheet
        readerVC.modalPresentationStyle = .formSheet
        present(readerVC, animated: true, completion: nil)
        
        
    }
    
    
    // MARK: - QRCodeReaderViewController Delegate Methods
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func loginbtnAct(_ sender: UIButton) {
        
        guard let emailT = emailTxt.text , let passT = passwordTxt.text else { return }
        guard emailT.isEmail else {
            self.view.showSimpleAlert("Error!!", "invalid Email Address", .warning)
            return }
        guard passT.isValidPassword else {
            self.view.showSimpleAlert("Error!!", "invalid Email Address", .warning)
            return }
        let userM = MUserData()
        userM.postLoginData(email: emailT, userPassword: passT) {[weak self] (data) in
            
            guard data.1 else {
                self?.view.showSimpleAlert("Error!!", "Request Failed, Please try again!", .warning)
                return
            }
            guard let profileData = data.0 else { return }
            print("that's the data : \(profileData.name) \(profileData.email) \(profileData.id) \(profileData.name) \(profileData)")
            self?.view.showSimpleAlert("Success", "Welcome \(profileData.name)", .success)
            ad.saveUserLogginData(email: profileData.email, photoUrl: profileData.photo, uid: profileData.id , name: profileData.name)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                 ad.reload()
            }
           
            
        }
    }
    
    @IBAction func forgotpassBtnAct(_ sender: UIButton) {
    }
    
    
}



