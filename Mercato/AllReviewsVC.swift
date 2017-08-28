//
//  AllReviewsVC.swift
//  Mercato
//
//  Created by Macbook Pro on 8/23/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit

class AllReviewsVC: UIViewConWithLoadingIndicator , LoginToReviewProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    
    let ratingTitles = ["drinks","food","services","employees","cleanness"]
    var totalRating :[Int]?
    var totalReviewClass : TotalReviews_Vars?{
        didSet {
            guard let data = totalReviewClass else { return }
            totalRating = [data.drinks,data.food,data.services,data.employees,data.cleanness]
            tableView.reloadData()
        }
    }
    let dataModel = MReviewData()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        self.loading()
        dataModel.getTotalReviews { [weak self] (data, code, status) in
            
            guard status , let data = data else {
                 self?.failedGettingData()
                return }
            self?.totalReviewClass = data
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toAddreviewBtnAct(_ sender: UIButtonX) {
        guard  ad.isUserLoggedIn() else {
            let vc = LoginViewC()
            vc.isModelView = true
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
            return
        }
        navToAddreview()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func navToAddreview() {
        performSegue(withIdentifier: "addReviewSegue", sender: self)
    }
}


extension AllReviewsVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewCell
        cell.nameTitle.text = ratingTitles[indexPath.row]
        guard let reviewData = totalRating else {
            cell.ratingView.value = CGFloat(0)
            return cell }
        cell.ratingView.value = CGFloat(reviewData[indexPath.row])
        return cell
    }
}
