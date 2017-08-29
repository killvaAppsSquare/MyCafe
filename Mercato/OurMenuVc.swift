//
//  OurMenuVc.swift
//  Mercato
//
//  Created by Macbook Pro on 8/24/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit
import AlamofireImage
 class OurMenuVc: UIViewConWithLoadingIndicator , UICollectionViewDelegateFlowLayout , UICollectionViewDataSource{

    @IBOutlet weak var collectionView: UICollectionView!
    var menuList = [GetMenuVars]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Menu"
        // Do any additional setup after loading the view.
        self.loading()
        let dataRequest = M_MenuData()
        dataRequest.getMenuData { [weak self ] (data, status) in
            
            guard status else {
                self?.failedGettingData()
                 return
            }
            
            guard let data = data else { return }
           
            DispatchQueue.main.async {
                 self?.menuList = data
                self?.collectionView.reloadData()
                self?.killLoading()

            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:self.collectionView.bounds.width   , height: collectionView.bounds.height )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OurMenuCell", for: indexPath) as! OurMenuCell
        if let url = URL(string: menuList[indexPath.row].photo) {
            cell.image.af_setImage(
                withURL: url ,
                placeholderImage: UIImage(named: "menu_loading"),
                filter: nil,
                imageTransition: .crossDissolve(0.2)
            )
        }
        cell.title.text = menuList[indexPath.row].name
        cell.configCell()
        return cell
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
