//
//  Helper.swift
//  Mercato
//
//  Created by Macbook Pro on 8/15/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import Foundation
import UIKit

class BaseCell : UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        
    }
    func setUpView() {
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
