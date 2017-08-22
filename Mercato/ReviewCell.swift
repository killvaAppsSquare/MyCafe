//
//  ReviewCell.swift
//  Mercato
//
//  Created by Macbook Pro on 8/16/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit
import SwiftyStarRatingView

protocol ReviewCellProtocol : class  {
    
    func addReview(_ tag : Int, _ ratingValue : Int)
}
class ReviewCell: UITableViewCell {

    weak var delegate : ReviewCellProtocol?
    
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var ratingView: SwiftyStarRatingView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ratingView.addTarget(self, action: #selector(addReview), for: .valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func addReview() {
        
        let value = ratingView.value
        
        delegate?.addReview(self.tag,Int(value))
    }

}
