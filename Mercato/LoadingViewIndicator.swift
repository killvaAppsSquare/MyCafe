//
//  LoadingViewIndicator.swift
//  Mercato
//
//  Created by Macbook Pro on 8/22/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    private   var loadingClass : IsLoadingView  {
             return IsLoadingView()
     }
 
      func loading() {
        loadingClass.isLoading(self)
           }
    
    func killLoading() {
        loadingClass.killLoading(self)
    }
    
 
    
    /*
    override func loadView() {
        super.loadView()
        
        var baseView = UIView()
        baseView.backgroundColor = UIColor(red: 13/255, green: 44/255, blue: 75/255, alpha: 1)
        self.view = baseView
        
        var progressIcon = UIActivityIndicatorView()
        progressIcon.setTranslatesAutoresizingMaskIntoConstraints(false)
        progressIcon.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        view.addSubview(progressIcon)
        progressIcon.startAnimating()
        
        var constraints = [NSLayoutConstraint]()
        constraints.append(NSLayoutConstraint(
            item: progressIcon,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: view,
            attribute: .CenterX,
            multiplier: 1,
            constant: 0)
        )
        constraints.append(NSLayoutConstraint(
            item: progressIcon,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: view,
            attribute: .CenterY,
            multiplier: 1,
            constant: 0)
        )
        
        view.addConstraints(constraints)
        
    }*/
    
}

   fileprivate  class IsLoadingView : NSObject {
    
    let backgroundView : UIView = {
       let backgView = UIView()
        backgView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
//        backgView.alpha = 0
        backgView.translatesAutoresizingMaskIntoConstraints = false
        return backgView
    }()
    
    let imageView : UIImageView =  {
        
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
          iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
      func isLoading(_ view : UIView) {
        guard  let window = UIApplication.shared.keyWindow else { return }

        view.addSubview(backgroundView)
        view.addSubview(imageView)
        setupAnimate_images()
//        setupAnimate_images()
        backgroundView.frame = window.frame

        let height = backgroundView.frame.height / 2
        //        let width = backgroundView.frame.width / 2

          view.addConstraints([NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)])
         view.addConstraints([NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: -50)])
//        view.addConstraints([NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .width, multiplier: 1, constant: 50)])
//        imageView.frame = CGRect(x: 0, y: 0 , width: 50, height: 50)
        view.addConstraintsWithFormat("H:[v0(100)]", views: imageView)
        view.addConstraintsWithFormat("V:[v0(100)]", views: imageView)

        UIView.animate(withDuration: 0.4) {
            
            self.backgroundView.alpha = 1
        }
    }
    func killLoading(_ view : UIView) {
        //        guard  let window = UIApplication.shared.keyWindow else { return }
        
          UIView.animate(withDuration: 0.4, animations: { 
            
            self.backgroundView.alpha = 0
          }) { (true) in
            self.backgroundView.removeFromSuperview()
        }
    }
    
    func setupAnimate_images()
    {
        
      
         var images = [UIImage]()
        for i in 1...13 {
            guard let img = UIImage(named: "\(i)") else { return }
            images.append(img)
        }
        imageView.animationImages = images
        imageView.animationDuration = 1.5
        imageView.animationRepeatCount = 0
        imageView.startAnimating()
    }
}


