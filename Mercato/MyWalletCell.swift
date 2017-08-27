//
//  MyWalletCell.swift
//  Mercato
//
//  Created by Killvak on 20/08/2017.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit

class MyWalletCell: UITableViewCell {

    @IBOutlet weak var myRedeemLabel: UILabel!
    @IBOutlet weak var expireDateLbl: UILabel!
    
   private  var qrValue : String?
   private  var expireDate : String?
    
   private var redeemPoint : String {
       guard  let x = qrValue else {
            return  ""
        }
        return "Redeemed Points = \(x) L.E"
    }
    
    private var expiresAt : String {
        guard  let x = expireDate else {
            return  ""
        }
        return "Expired at : \(x)"
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
     

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(_ data : UserPoints_Vars) {
        qrValue = data.value
        expireDate = data.expire_date
        
        myRedeemLabel.text = redeemPoint
        expireDateLbl.text = expiresAt
    }
    
}
