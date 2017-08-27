//
//  RedeemPointsHeaderVC.swift
//  Mercato
//
//  Created by Killvak on 20/08/2017.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit

class RedeemPointsHeaderVC: UICollectionReusableView {
    
    @IBOutlet weak var myPointsLbl: UILabel!
    var redeemPointsVC : RedeemPointsVC?
    
    var myPoints : Int? {
        didSet{
        guard let mpt = myPoints else { return }
        
        myPointsLbl.text = "Your points = \(mpt) point."
    }
    }

}
