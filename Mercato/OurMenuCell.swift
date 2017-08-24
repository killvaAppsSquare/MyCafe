//
//  OurMenuCell.swift
//  Mercato
//
//  Created by Macbook Pro on 8/24/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit

class OurMenuCell: UICollectionViewCell , UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    func configCell() {
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        scrollView.delegate = self 
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return image
    }
}
