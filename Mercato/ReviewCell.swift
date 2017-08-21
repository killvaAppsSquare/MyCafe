//
//  ReviewCell.swift
//  Mercato
//
//  Created by Macbook Pro on 8/16/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit
import SwiftyStarRatingView

class ReviewCell: UITableViewCell {

    
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var ratingView: SwiftyStarRatingView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
