//
//  OurProductsVC.swift
//  Mercato
//
//  Created by Macbook Pro on 8/15/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit

class OurProductsVC: UIViewConWithLoadingIndicator  {

    @IBOutlet weak var collectionView: UICollectionView!

    
     var productList = [GetProductsVars]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(OurProductsCell.self, forCellWithReuseIdentifier: "MainCell")
        
        self.loading()
        let dataRequest = M_MenuData()
        dataRequest.getProductsData { [weak self ] (data, status) in
            
            guard status else {
                self?.failedGettingData()
                return
            }
            
            guard let data = data else { self?.failedGettingData(); return }
            
            DispatchQueue.main.async {
                self?.productList = data
                self?.collectionView.reloadData()
                self?.killLoading()
                
            }
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension OurProductsVC : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        
        switch indexPath.row {
        case 0: break
        default: break
//            performSegue(withIdentifier: reviewSegue, sender: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collectionView.bounds.width , height: collectionView.bounds.height / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
    }
    
    
}

extension OurProductsVC : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as! OurProductsCell
        cell.label.text = productList[indexPath.row].name
        
        if let url = URL(string: productList[indexPath.row].photo) {
            cell.imageView.af_setImage(
                withURL: url ,
                placeholderImage: UIImage(named: "menu_loading"),
                filter: nil,
                imageTransition: .crossDissolve(0.2)
            )
        }
         return cell
    }
}




class OurProductsCell : BaseCell {
    
    let imageView : UIImageView =  {
        
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "menu-coffee-outside-cafe")
        return iv
    }()
    let blackView : UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        return view
    }()
    let label : UILabel = {
       let lbl = UILabel()
        lbl.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        lbl.text = "hi"
        lbl.textColor = .white
        lbl.tag = 20
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 20.0)
        return lbl
    }()
    override func setUpView() {
        self.clipsToBounds = true
        addSubview(imageView)
        addSubview(blackView)
        addSubview(label)

        addConstraintsWithFormat("H:|[v0]|", views: imageView)
        addConstraintsWithFormat("V:|[v0]|", views: imageView)
        
        addConstraintsWithFormat("H:|[v0]|", views: blackView)
        addConstraintsWithFormat("V:|[v0]|", views: blackView)


        addConstraintsWithFormat("H:|[v0]|", views: label)

        addConstraints([NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: imageView, attribute: .centerX, multiplier: 1, constant: 0)])
        addConstraints([NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: imageView, attribute: .centerY, multiplier: 1, constant: 0)])
        
        addConstraints([NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .height, multiplier: 1/4, constant: 0)])

    }
}
