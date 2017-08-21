//
//  AboutUsVC.swift
//  Mercato
//
//  Created by Killvak on 20/08/2017.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit

class AboutUsVC: UIViewController {

    
    let imageView : UIImageView =  {
        
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named:"location_pic")
        return iv
    }()
    let sepratorView : UIView = {
        let hv = UIView()
        hv.backgroundColor = .darkRed
        return hv
    }()
    
    let textView : UITextView = {
       let tv = UITextView()
        tv.isEditable = false
        tv.textColor = .darkGray
        tv.text = "ldjflasjlfsajlsjalkasfjl kasjkl asjklf jaslkdjaskj dkaslj ghwuoeoq w ,cmqkwjp qwkl;qwj"
           tv.font = UIFont.boldSystemFont(ofSize: 18)
        return tv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        self.view.addSubview(imageView)
        self.view.addSubview(sepratorView)
        self.view.addSubview(textView)

        let imageVheight = self.view.frame.height * 0.2
        view.addConstraintsWithFormat("H:|[v0]|", views: imageView)
        view.addConstraintsWithFormat("H:|[v0]|", views: sepratorView)
        view.addConstraintsWithFormat("H:|-12-[v0]-12-|", views: textView)
        view.addConstraintsWithFormat("V:|[v0(\(imageVheight))][v1(5)]-8-[v2]|", views: imageView,sepratorView,textView)


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
