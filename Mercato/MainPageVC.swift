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
    
    var titles = ["Join Us","Menu","About Us","Our Products","Our Location","Reviews"]
    fileprivate let reviewSegue = "mTrSegue"

    
    let imgList = [UIImage(named: "join_us"),UIImage(named: "Meni_MainPage_icon"),UIImage(named: "aboutus_icon"),UIImage(named: "products_icon"),UIImage(named: "location_icon"),UIImage(named: "reviews_icon")]
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
//    updateFirstRowTitle()
        
        let btn2 = UIButton(type: .custom)
        btn2.setImage(UIImage(named: "sidemenu_icon"), for: .normal)
        btn2.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        btn2.addTarget(self, action: #selector(sidemenuBtnAct), for: .touchUpInside)
        let item2 = UIBarButtonItem(customView: btn2)
        
        self.navigationItem.setLeftBarButtonItems([item2], animated: true)

    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
   updateFirstRowTitle()
    }
    
    func updateFirstRowTitle() {
        if  ad.isUserLoggedIn() , titles[0] != "Profile" {
            titles[0] = "Profile"
//            self.collectionView?.reloadItems(at: [IndexPath(row: 0, section: 0)])
            self.collectionView.reloadData()
            self.view.layoutIfNeeded()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
viewDidLayoutSubviews()
     }
    func sidemenuBtnAct() {
        menuView.showMenu()
           self.navigationItem.leftBarButtonItem?.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
            self.navigationItem.leftBarButtonItem?.isEnabled = true 
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func callLogin(){
//        if !ad.isUserLoggedIn() {
//            let vc = LoginViewC()
//            self.navigationController?.pushViewController(vc, animated: true)
//            return
//        }
//    }
    func navigatieToView ( _ selected : MenuList) {
        guard ad.isUserLoggedIn()   else {
            let vc = LoginViewC()
            vc.guideDelegate = self
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        switch selected {
        case .MyProfile :
            let vc = ProfileVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case .MyWallet :
           let vc =  self.storyboard?.instantiateViewController(withIdentifier: "MyWalletVC") as! MyWalletVC
            self.navigationController?.pushViewController(vc, animated: true)   
        case .Reddem :
            let vc =  self.storyboard?.instantiateViewController(withIdentifier: "RedeemPointsVC") as! RedeemPointsVC
            self.navigationController?.pushViewController(vc, animated: true)
        case .Offers :
//            menuView.handleDismiss()
//            self.view.showSimpleAlert("Comming Soon", "", .alarm)
            let vc = MyGuidePagerVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case .Logout :
            self.view.showSimpleAlert("LoggingOut", "loading...", .alarm)
            self.view.isUserInteractionEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {

            ad.saveUserLogginData(email: nil, photoUrl: nil, uid: nil, name: nil)
                self.view.isUserInteractionEnabled = true
                ad.reload()
            }
            
        default : break
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
                guard ad.isUserLoggedIn() else {
                    let vc = LoginViewC()
                     vc.guideDelegate = self
                    navigationController?.pushViewController(vc, animated: true)
                    return }
                let vc = ProfileVC()
                navigationController?.pushViewController(vc, animated: true)
         case 1 : //Menu
            performSegue(withIdentifier : "HomeToMenuSegue",sender: self )
        case 2 : //About Us
            print("it's all About Us")
            let vc = AboutUsVC()
            self.navigationController?.pushViewController(vc, animated: true)

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
        }else {
             cell.backgroundColor =  UIColor.lightRed
            cell.label.textColor = .white
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
//    let blackView : UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//        return view
//    }()
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
//        self.backgroundColor =  UIColor.lightRed
        let imageSize = self.frame.width * 0.6
        addConstraintsWithFormat("H:[v0(\(imageSize))]", views: imageView)
        addConstraintsWithFormat("H:|[v0]|", views: label)

        addConstraintsWithFormat("V:[v0(\(imageSize))]-3-[v1]", views: imageView,label)

        addConstraints([NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0 )])
        addConstraints([NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: -8)])
    }
}


extension MainPageVC : LoginToMainProtocol {
    func showPointGuide() {
        
        let vc = PointsGuideVC()
        self.present(vc, animated: true, completion: nil)   
    }
    
}
