//
//  OurProductsVC.swift
//  Mercato
//
//  Created by Macbook Pro on 8/15/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit

class OurProductsVC: UIViewController  {

    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate let reviewSegue = "pTrSegue"

    let titles = ["Join Us","Menu","About Us","Our Products","Our Location","Reviews"]
    
    let imgList = [UIImage(named:"pexels-photo-64775"),UIImage(named:"menu-coffee-outside-cafe"),UIImage(named:"pexels-photo-296882"),UIImage(named:"pexels-photo-296888"),UIImage(named:"menu-coffee-outside-cafe"),UIImage(named:"pexels-photo-532753")]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(MainVcCells.self, forCellWithReuseIdentifier: "MainCell")
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
        default:
            performSegue(withIdentifier: reviewSegue, sender: self)
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
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as! MainVcCells
        cell.label.text = titles[indexPath.row]
        
        cell.imageView.image = imgList[indexPath.row]
        return cell
    }
}




class MainVcCells : BaseCell {
    
    let imageView : UIImageView =  {
        
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "menu-coffee-outside-cafe")
        return iv
    }()
    
    let label : UILabel = {
       let lbl = UILabel()
        lbl.backgroundColor = UIColor.black.withAlphaComponent(0.7)
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
        addSubview(label)
        let lblHeight = self.bounds.height / 6
        addConstraintsWithFormat("H:|[v0]|", views: imageView)
        addConstraintsWithFormat("V:|[v0]|", views: imageView)
        
//        addConstraintsWithFormat("V:[v0(\(lblHeight))]|", views: label)
        addConstraintsWithFormat("H:|[v0]|", views: label)

        addConstraints([NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: imageView, attribute: .centerX, multiplier: 1, constant: 0)])
        addConstraints([NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: imageView, attribute: .centerY, multiplier: 1, constant: 0)])
        
        addConstraints([NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .height, multiplier: 1/4, constant: 0)])

    }
}
