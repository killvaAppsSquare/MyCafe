//
//  LoadingViewIndicator.swift
//  Mercato
//
//  Created by Macbook Pro on 8/22/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import Foundation
import UIKit
 
class UIViewConWithLoadingIndicator : UIViewController {
    
   private  lazy var  loadingClass : IsLoadingView = {
        let vc = IsLoadingView()
        return vc
    }()
    
 
      func loading() {
        
        loadingClass.isLoading(self.view)
           }
    
    func killLoading() {
        loadingClass.killLoading(self.view)
    }
    
    func failedGettingData() {
        DispatchQueue.main.async {
            
            self.view.showSimpleAlert("Error!!", "Couldn't retrieve data,Please try again!", .error)
            self.killLoading()
            guard self.navigationController  != nil else {
                self.dismiss(animated: true, completion: nil)
                return
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
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
    
    let label : UILabel = {
        
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.text = "Loading..."
        return lbl
    }()
    
      func isLoading(_ view : UIView) {
        guard  let window = UIApplication.shared.keyWindow else { return }

        view.addSubview(backgroundView)
        view.addSubview(imageView)
        view.addSubview(label)

        setupAnimate_images()
//        setupAnimate_images()
        backgroundView.frame = window.frame

        let height = backgroundView.frame.height * 0.2
        //        let width = backgroundView.frame.width / 2

          view.addConstraints([NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)])
         view.addConstraints([NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: -50)])
//        view.addConstraints([NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .width, multiplier: 1, constant: 50)])
//        imageView.frame = CGRect(x: 0, y: 0 , width: 50, height: 50)
        view.addConstraintsWithFormat("H:[v0(\(height))]", views: imageView)
        view.addConstraintsWithFormat("H:|[v0]|", views: label)
        view.addConstraintsWithFormat("V:[v0(\(height))]-2-[v1]", views: imageView,label)
 
        UIView.animate(withDuration: 0.4) {
            self.backgroundView.alpha = 1
            self.imageView.alpha = 1
            self.label.alpha = 1
        }
    }
    func killLoading(_ view : UIView) {
        //        guard  let window = UIApplication.shared.keyWindow else { return }
        
          UIView.animate(withDuration: 0.4, animations: { 
            self.label.alpha = 0
            self.imageView.alpha = 0
            self.backgroundView.alpha = 0
          }) { (true) in
            self.label.removeFromSuperview()
            self.imageView.removeFromSuperview()
            self.backgroundView.removeFromSuperview()
        }
    }
    
    func setupAnimate_images()
    {
        
      
         var images = [UIImage]()
        for i in 1...50 {
            guard let img = UIImage(named: "\(i).png") else { return }
            images.append(img)
        }
        imageView.animationImages = images
        imageView.animationDuration = 1.5
        imageView.animationRepeatCount = 0
        imageView.startAnimating()
    }
        
     
}


