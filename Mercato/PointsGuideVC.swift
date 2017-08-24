//
//  PointsGuideVC.swift
//  Mercato
//
//  Created by Macbook Pro on 8/23/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit

class PointsGuideVC: UIViewController  , UICollectionViewDelegateFlowLayout , UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
//        collectionView.re/gister(PointsGuideCell.self , forCellWithReuseIdentifier: "PointsGuideCell")
         self.collectionView.register(UINib(nibName: "PointsGuideCell", bundle: nil), forCellWithReuseIdentifier: "PointsGuideCell")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PointsGuideCell", for: indexPath) as! PointsGuideCell
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return  CGSize(width: self.collectionView.frame.width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
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
