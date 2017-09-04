//
//  AddReviewVC.swift
//  Mercato
//
//  Created by Macbook Pro on 8/16/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit

class AddReviewVC: TextFieldKeyBoardhandler , ReviewCellProtocol , UITextViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var submitBtnOL: UIButtonX!
    
    var valueForReview = [String:Any]()
    let ratingTitles = ["drinks","food","services","employees","cleanness"]
    let textViewPlaceHolder = "Write your comment here..."
    var startEditing = false

    override func viewDidLoad() {
        super.viewDidLoad()
          title = "Add Reviews"
        //        tableView.delegate = self
        tableView.dataSource = self
        textView.text = textViewPlaceHolder
        textView.textColor = UIColor.lightGray
        textView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //        IQKeyboardManager.sharedManager().enable = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitBtnAct(_ sender: UIButtonX) {
        guard startEditing else {
            self.view.showSimpleAlert("Sorry", "You have to rate at least one Service", .notification)
            return
        }
        valueForReview["user_id"] =  USER_ID
        if textView.text != "Write your comment here..." {
            valueForReview["notes"] = textView.text
        }

        let reviewM = MReviewData()
        print("that's the value ; \(valueForReview)")
        
         
        self.loading()
        reviewM.postReview(parameters: valueForReview) { [weak self](status) in
            let reviewedOnce = status.0
            print("that's the value : \(reviewedOnce), \(status.0) , \(status.1)")

            if status.1 {
                guard !reviewedOnce else {
                    DispatchQueue.main.async {
                        self?.view.showSimpleAlert("Attention!!", "You only can review us once per day", .warning)
                        self?.navigationController?.popViewController(animated: true)
                    }
                    print("You Spammer") ; self?.killLoading(); return }
                DispatchQueue.main.async {
                    self?.view.showSimpleAlert("Thank You", "Your review is much appreciated.", .success)
                    self?.navigationController?.popViewController(animated: true)
                }
               self?.killLoading();
            }else {
                print("Dam u Adolf"); self?.killLoading();
                DispatchQueue.main.async {
                    self?.view.showSimpleAlert("Error!!", "Couldn't Complete request please try again!!", .warning)
                }
                
            }
        }
        
    }
    
    func addReview(_ tag: Int, _ ratingValue: Int) {
        //         print("thatit cell : \(tag ) and the rating : \(ratingValue)")
        valueForReview[ratingTitles[tag]] = ratingValue
        print("that's the value ; \(valueForReview)")
        startEditing = true
        
    }
    
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.darkGray
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


extension AddReviewVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewCell
        cell.tag = indexPath.row
        cell.nameTitle.text = ratingTitles[indexPath.row]
        cell.delegate = self 
        return cell
    }
}



