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

protocol  LoginToReviewProtocol : class  {
    func navToAddreview()
}
class LoginViewC: UIViewConWithLoadingIndicator , RegisterToLoginProtocol{
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var loginBtnOL: UIButton!
    @IBOutlet weak var modelViewNavBarHeight: NSLayoutConstraint!
    
    var isModelView = false
    weak var delegate : LoginToReviewProtocol?
 
    
 
    
    // Good practice: create the reader lazily to avoid cpu overload during the
    // initialization and each time we need to scan a QRCode
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode], captureDevicePosition: .back)
        }
        builder.cancelButtonTitle = "Back to Normal Loggin"
        return QRCodeReaderViewController(builder: builder)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        modelViewNavBarHeight.constant = isModelView ? 64 : 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
//    @IBAction func loginbtnAct(_ sender: UIButton) {
//
//    }
    @IBAction func loginbtnAct(_ sender: UIButton) {
        //Test Login
        if emailTxt.text == "ryuu" {
            emailTxt.text = "test@test.com"
            passwordTxt.text = "1234"
        }
        //
        guard let emailT = emailTxt.text , let passT = passwordTxt.text else { return }
        guard emailT.isEmail else {
            self.view.showSimpleAlert("Error!!", "invalid Email Address", .warning)
            return }
        guard passT.isValidPassword else {
            self.view.showSimpleAlert("Error!!", "invalid Email Address", .warning)
            return }
        let userM = MUserData()
        self.loading()
        userM.postLoginData(email: emailT, userPassword: passT) {[weak self] (data) in
            
            guard data.1 else {
                DispatchQueue.main.async {
                    self?.killLoading()
                    self?.view.showSimpleAlert("Error!!", "Request Failed, Please try again!", .warning)
                }
                return
            }
            guard let profileData = data.0 else {
                DispatchQueue.main.async {
                    self?.killLoading()
                }
                return }
//            print("that's the data : \(profileData.name) \(profileData.email) \(profileData.id) \(profileData.name) \(profileData)")
            ad.saveUserLogginData(email: profileData.email, photoUrl: profileData.photo, uid: profileData.id , name: profileData.name)
            DispatchQueue.main.async {
               self?.killLoading()
                self?.view.showSimpleAlert("Success", "Welcome \(profileData.name)", .success)
                self?.handleLoginViewNav()
            }
            
            
        }
    }
    
 
    func handleLoginViewNav() {
        guard isModelView else {
            navigationController?.popViewController(animated: true)
            return
        }
            self.dismiss(animated: true) { [weak self] (true) in
                self?.delegate?.navToAddreview()
        }
}
    func sendSignalToAllReview() {
        self.dismiss(animated: true) { [weak self] (true) in
            self?.delegate?.navToAddreview()
        }
    }
    
    @IBAction func forgotpassBtnAct(_ sender: UIButton) {
        let vc = RegistrationVC()
        vc.isModelView = true
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func modelViewDismissBtn(_ sender: UIButtonX) {
        self.presentingViewController?.dismiss(animated : true)
    }
    
}







extension LoginViewC :QRCodeReaderViewControllerDelegate {
    
    @IBAction func scanAction(_ sender: AnyObject) {
        // Retrieve the QRCode content
        // By using the delegate pattern
        readerVC.delegate = self
        
        // Or by using the closure pattern
        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
            //            print(result)
        }
        
        // Presents the readerVC as modal form sheet
        readerVC.modalPresentationStyle = .formSheet
        present(readerVC, animated: true, completion: nil)
    }
    
    
    
    
    
    // MARK: - QRCodeReaderViewController Delegate Methods
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        self.dismiss(animated: true, completion: { () -> Void in
            
            // use the result variable here.
            let vc = RegistrationVC()
            //
            DispatchQueue.main.async {
                guard result.value == "Register" else {
                    self.view.showSimpleAlert("QR Code Not Found!!", "Plaese try again!", .warning)
                    return
                }
                guard let nav = self.navigationController  else {
                    vc.delegate = self 
                    vc.isModelView = true
                    self.present(vc, animated: true, completion: nil)
                    return
                }
                nav.pushViewController(vc, animated: true)
            }
        })
    }
    
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
    }
    
    
}
