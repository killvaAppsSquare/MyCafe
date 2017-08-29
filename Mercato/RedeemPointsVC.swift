//
//  RedeemPointsVC.swift
//  Mercato
//
//  Created by Killvak on 20/08/2017.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit

class RedeemPointsVC: UIViewConWithLoadingIndicator  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let redeemModel = M_User_Points()
    let mPoints = M_User_Points()
    
    var pointsData = [User_RedeemPoints_Var]()
    var myPoints : Int?
    
    var  reusableview = RedeemPointsHeaderVC()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Redeem Points"
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        self.loading()
        mPoints.getPointsRedeemList { [weak self] (data) in
            guard  data.2 else  {
                self?.failedGettingData()
                return
            }
            DispatchQueue.main.async {
                guard let pointDataa = data.0 ,let  point = data.1 else {
                    self?.failedGettingData()
                    return }
                
                self?.pointsData = pointDataa
                self?.myPoints = point
                self?.reusableview.myPoints = point
                self?.killLoading()
                self?.collectionView.reloadData()
            }
        }
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

extension RedeemPointsVC :UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("sup ")
        guard let points = myPoints ,  pointsData[indexPath.row].points <= points else {
            self.view.showSimpleAlert("Sorry", "But you don't have Enough Points", .alarm)
            return
        }
        self.loading()
        redeemModel.postRedeemPoints(pointID:  pointsData[indexPath.row].id) { [weak self] (data, status) in
            guard status , let dataa = data else  {
                self?.failedGettingData()
                return
            }
            DispatchQueue.main.async {
                self?.killLoading()
                let vc = RedeemedCodeVC()
                vc.imageLink = dataa.qr_png
                vc.qrCodeValue = dataa.value
                vc.reddemedCode = true
                self?.navigationController?.pushViewController(vc, animated: true)

                
            }
            
            
        }
        
          }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return    CGSize(width: (self.collectionView.frame.width / 2 ) - 1, height:155)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return    CGSize(width: self.collectionView.frame.width , height:230)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            reusableview  = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "RedeemPointsHeaderVC", for: indexPath) as! RedeemPointsHeaderVC
            
            reusableview.redeemPointsVC = self
            //            reusableview.frame = CGRect(width: self.collectionView.frame.width , height:230)
            //do other header related calls or settups
            return reusableview
            
            
        default:  fatalError("Unexpected element kind")
        }
    }
}

extension RedeemPointsVC : UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pointsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RedeemsPointsCell", for: indexPath) as! RedeemsPointsCell
        let point = pointsData[indexPath.row].points
        cell.redeemPoints.text = "Redeem \(point)"
        
        return cell
    }
    
}
