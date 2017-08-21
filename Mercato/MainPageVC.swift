//
//  MainPageVC.swift
//  Mercato
//
//  Created by Macbook Pro on 8/15/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit

class MainPageVC: UIViewController  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let titles = ["Join Us","Menu","About Us","Our Products","Our Location","Reviews"]
    fileprivate let reviewSegue = "mTrSegue"

    let imgList = [#imageLiteral(resourceName: "join_us"),#imageLiteral(resourceName: "menu_icon"),#imageLiteral(resourceName: "aboutus_icon") ,#imageLiteral(resourceName: "products_icon"),#imageLiteral(resourceName: "location_icon"),#imageLiteral(resourceName: "reviews_icon")]
    
    lazy var  menuView : MenuNsView = {
       let vc = MenuNsView()
        vc.mainpageController = self
        
        return vc
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(MainVcCells.self, forCellWithReuseIdentifier: "MainCell")
    
        
        let btn2 = UIButton(type: .custom)
        btn2.setImage(UIImage(named: "sidemenu_icon"), for: .normal)
        btn2.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        btn2.addTarget(self, action: #selector(sidemenuBtnAct), for: .touchUpInside)
        let item2 = UIBarButtonItem(customView: btn2)
        
        self.navigationItem.setLeftBarButtonItems([item2], animated: true)

    
    }
    
    func sidemenuBtnAct() {
        menuView.showMenu()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    func navigatieToView ( _ selected : MenuList) {
        switch selected {
        case .MyProfile : break
        case .MyWallet :
           let vc =  self.storyboard?.instantiateViewController(withIdentifier: "MyWalletVC") as! MyWalletVC
            self.navigationController?.pushViewController(vc, animated: true)   
        case .Reddem :
            let vc =  self.storyboard?.instantiateViewController(withIdentifier: "RedeemPointsVC") as! RedeemPointsVC
            self.navigationController?.pushViewController(vc, animated: true)
        case .Offers :
            menuView.handleDismiss()
            let vc = AboutUsVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case .Logout : break
        }
        print(selected.rawValue)
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

extension MainPageVC : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        
        switch indexPath.row {
             case 0 : // Join us
//            let vc = RegistrationVC()
//            navigationController?.pushViewController(vc, animated: true)
         case 1 : //Menu
            print("Puna bete")
        case 2 : //About Us
            print("it's all About Us")
        case 3 : //Products
            performSegue(withIdentifier: "ourProductsSegue", sender: self)
        case 4 : //Our Location
            let vc = LocationOnMapVC()
            navigationController?.pushViewController(vc, animated: true)
        default : // Reviews
              print("Reviews")
            performSegue(withIdentifier: reviewSegue, sender: self)
            
            }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:self.view.frame.width / 2 , height: collectionView.bounds.height / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}

extension MainPageVC : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as! MainVcCells
        if indexPath.row == 0 || indexPath.row == 3  || indexPath.row == 4  {
            cell.backgroundColor = .white
            cell.label.textColor = .darkRed
        }
        cell.label.text = titles[indexPath.row]
        
        cell.imageView.image = imgList[indexPath.row]
        return cell
    }
}


class MainVcCells : BaseCell {
    
    let imageView : UIImageView =  {
        
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    let blackView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        return view
    }()
    let label : UILabel = {
        let lbl = UILabel()
//        lbl.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        lbl.textColor = .white
        lbl.tag = 20
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 22.0)
        return lbl
    }()
    
    
    override func setUpView() {
        self.clipsToBounds = true
        addSubview(imageView)
        //        addSubview(blackView)
        addSubview(label)
        
        //        imageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45)
        //        imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45)
        //         self.backgroundColor =  UIColor.lightRed
        self.backgroundColor =  UIColor.lightRed
        let imageSize = self.frame.width * 0.6
        addConstraintsWithFormat("H:[v0(\(imageSize))]", views: imageView)
        addConstraintsWithFormat("H:|[v0]|", views: label)

        addConstraintsWithFormat("V:[v0(\(imageSize))]-3-[v1]", views: imageView,label)

        addConstraints([NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0 )])
        addConstraints([NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: -8)])
//        addConstraints([NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.6, constant: 0)])
//        addConstraints([NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.6, constant: 0)])
////        
//        addConstraints([NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: 3 )])
//        addConstraints([NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0 )])
////        addConstraints([NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 20)])
//        addConstraints([NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.85, constant: 0)])

        //        addConstraints([NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0 )])
        //           addConstraints([NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        
        //        addConstraintsWithFormat("H:|[v0]|", views: imageView)
        //        addConstraintsWithFormat("V:|[v0]|", views: imageView)
        //
        //        addConstraintsWithFormat("H:|[v0]|", views: blackView)
        //        addConstraintsWithFormat("V:|[v0]|", views: blackView)
        //
        //
        //        addConstraintsWithFormat("H:|[v0]|", views: label)
        //
        //        addConstraints([NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: imageView, attribute: .centerX, multiplier: 1, constant: 0)])
        //        addConstraints([NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: imageView, attribute: .centerY, multiplier: 1, constant: 0)])
        //
        //        addConstraints([NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .height, multiplier: 1/4, constant: 0)])
        
    }
}
