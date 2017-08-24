//
//  MyScrollTest.swift
//  Mercato
//
//  Created by Macbook Pro on 8/24/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit

class MyScrollTest: UIViewController , UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgPhoto: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        // scrollView.delegate = self - it is set on the storyboard.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return imgPhoto
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
