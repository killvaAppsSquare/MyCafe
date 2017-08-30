//
//  MenuNsView.swift
//  Mercato
//
//  Created by Killvak on 20/08/2017.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit

enum MenuList : String {
    
    case MyProfile = "My Profile"
    case MyWallet = "My Wallet"
    case Reddem = "Redeem Points"
    case Offers = "Offers"
    case Logout = "Logout"
}

class MenuNsView: NSObject {

    let headerView : UIView = {
       let hv = UIView()
        hv.backgroundColor = .darkRed
        return hv
    }()
    
    
    
    let menuView : UIView = {
        let hv = UIView()
        hv.backgroundColor = .lightRed
        return hv
    }()
    let label : UILabel = {
        
       let lbl = UILabel()
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.text = "Menu"
        return lbl
    }()
    
    let dismissBtn : UIButton = {
       let btn = UIButton()
        btn.setTitle("X", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.white.cgColor
        return btn
    }()
    
    let collectionView : UICollectionView = {
       
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .clear
        return  cv
    }()
    
    var menuList : [MenuList] = [.MyProfile, .MyWallet,.Reddem,.Offers,.Logout]
    var mainpageController : MainPageVC?
    
    func showMenu() {
        
        if let window = UIApplication.shared.keyWindow {
            
            window.addSubview(menuView)
            menuView.addSubview(headerView)
            menuView.addSubview(collectionView)

            menuView.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
            headerView.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: 64 )
            
            collectionView.frame = CGRect(x: 0, y: 120, width:window.frame.width, height: window.frame.height - 80)
            headerSetup(window)
            menuView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            if ad.isUserLoggedIn()  {
                menuList = [.MyProfile, .MyWallet,.Reddem,.Offers,.Logout]
            }else {
               menuList = [.MyProfile, .MyWallet,.Reddem,.Offers]
            }
            collectionView.reloadData()
            UIView.animate(withDuration: 0.8, animations: {
                self.menuView.transform = .identity
                self.menuView.alpha = 1
            })
        }
    }
    func headerSetup(_ window : UIWindow) {
        
        headerView.addSubview(label)
        headerView.addSubview(dismissBtn)
        
        label.frame = CGRect(x: ( window.frame.width  / 2 ) - 30, y: 25, width: 60, height: 30)
        dismissBtn.frame = CGRect(x: 8, y: 25, width: 30, height: 30)
        dismissBtn.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)

    }
    func handleDismiss() {
       
        UIView.animate(withDuration: 0.5, animations: { 
//            self.menuView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self.menuView.alpha = 0
        }) { (true) in
            self.headerView.removeFromSuperview()

           self.menuView.removeFromSuperview()
            
        }
    }
    override init() {
        super.init()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MyMenuCell.self , forCellWithReuseIdentifier: "CellID ")
    }
    
}
extension MenuNsView :UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleDismiss()
        if mainpageController != nil {
        self.mainpageController?.navigatieToView(menuList[indexPath.row])
    }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     return    CGSize(width: self.collectionView.frame.width, height:50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
}

extension MenuNsView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellID ", for: indexPath) as! MyMenuCell
        cell.tag = indexPath.row
        cell.label.text = menuList[indexPath.row].rawValue

//        guard ad.isUserLoggedIn() else {
//            if menuList.count - 2 == indexPath.row {
//                cell.seprator.backgroundColor = .clear
//            }
//             if menuList.count - 1 == indexPath.row {
//                cell.seprator.backgroundColor = .clear
//                cell.label.text = ""
//            }
//            return cell
//        }
//        if cell.label.text == "Logout" , cell.tag == indexPath.row {
        if menuList.count - 1 == indexPath.row ,  indexPath.row == cell.tag{
            cell.seprator.backgroundColor = .clear
        }else {
            cell.seprator.backgroundColor = .white

        }
        return cell
    }
    
}

class MyMenuCell: BaseCell {
    let label : UILabel = {
        
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 23)
        lbl.textAlignment = .center
        lbl.text = "Menu"
        return lbl
    }()
    let seprator : UIView = {
        let hv = UIView()
        hv.backgroundColor = .white
        return hv
    }()
    
    override func setUpView() {
        super.setUpView()
        
        self.addSubview(label)
        self.addSubview(seprator)
        
        addConstraintsWithFormat("H:|[v0]|", views: label)
        addConstraintsWithFormat("H:|[v0]|", views: seprator)
        
        addConstraintsWithFormat("V:|[v0]-15-[v1(1)]-|", views: label,seprator)
 

    }
    
    
    
    
    
}


















