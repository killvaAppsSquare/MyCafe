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
    var isZoomed = false
    func configCell() {
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(pinToZoom))
        tapRecognizer.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(tapRecognizer)
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        scrollView.delegate = self 
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return image
    }
    
    func pinToZoom() {
        
        if isZoomed {
            isZoomed = false
            scrollView.zoomScale = 1.0
            
        }else {
            isZoomed = true
            scrollView.zoomScale = 3.0
        }
    }
}
