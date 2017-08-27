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
    private var redeemPoint : String {
        guard  let x = qrCodeValue else {
            return  ""
        }
        return "QR Code  = \(x) L.E"
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        qrCodeLbl.text = redeemPoint
        print("that's the imageLink : \(imageLink)")
        if let urlString = imageLink ,  let url = URL(string: urlString) {
 
        imageView.af_setImage(
            withURL: url ,
            placeholderImage: UIImage(named: "menu_loading"),
            filter: nil,
            imageTransition: .crossDissolve(0.2)
        )
        }
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
