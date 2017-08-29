//
//  RedeemedCodeVC.swift
//  Mercato
//
//  Created by Macbook Pro on 8/24/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit
import AlamofireImage

class RedeemedCodeVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var qrCodeLbl: UILabelX!
    
    var imageLink : String?
    var qrCodeValue : String?
    var reddemedCode = false
    private var redeemPoint : String {
        guard  let x = qrCodeValue else {
            return  ""
        }
        return "QR Code  = \(x) L.E"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Your QR Code"
        // Do any additional setup after loading the view.
        if reddemedCode {
            
            
            let button = UIButton.init(type: .custom)
            button.setImage(UIImage.init(named: "backBtn"), for: UIControlState.normal)
            button.addTarget(self, action:#selector(backToInitial), for: .touchUpInside)
            button.frame = CGRect.init(x: 0, y: 0, width: 20, height: 20) //CGRectMake(0, 0, 30, 30)
            let barButton = UIBarButtonItem.init(customView: button)
            self.navigationItem.leftBarButtonItem = barButton
        }
        
        qrCodeLbl.text = redeemPoint
        //        print("that's the imageLink : \(String(describing: imageLink))")
        if let urlString = imageLink ,  let url = URL(string: urlString) {
            
            imageView.af_setImage(
                withURL: url ,
                placeholderImage: UIImage(named: "menu_loading"),
                filter: nil,
                imageTransition: .crossDissolve(0.2)
            )
        }
    }
    
    
    func backToInitial() {
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
