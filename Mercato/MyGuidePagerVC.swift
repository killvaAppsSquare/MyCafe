//
//  MyGuidePagerVC.swift
//  Mercato
//
//  Created by Macbook Pro on 9/3/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit
import FSPagerView

class MyGuidePagerVC: UIViewController, FSPagerViewDataSource , FSPagerViewDelegate {
//    @IBOutlet weak var pagerView: FSPagerView! {
//        didSet {
//            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
//        }
//    }

    
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return images.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = images[index]
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true 
//            cell.textLabel?.text = ...
        return cell
    }
 
    let images = [UIImage(named:"menu_pic01"),UIImage(named:"menu_pic02"),UIImage(named:"menu_pic03")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a pager view
        let pagerView = FSPagerView(frame: self.view.frame)
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        self.view.addSubview(pagerView)
        // Create a page control
        let pageControl = FSPageControl(frame: CGRect(x: 0, y: self.view.frame.height - 30 , width: self.view.frame.width, height: 30   ))
        self.view.addSubview(pageControl)
    
    }
    
  

}
