//
//  MyWalletVC.swift
//  Mercato
//
//  Created by Killvak on 20/08/2017.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit

class MyWalletVC: UIViewConWithLoadingIndicator ,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var emptyWalletLbl: UILabel!

    @IBOutlet weak var tableView: UITableView!
    
    let m_WalletData = M_User_Points()
    
    var cardsData = [UserPoints_Vars]() {
        didSet {
            guard cardsData.count > 0 else {
                emptyWalletLbl.alpha = 1
                return
            }
            emptyWalletLbl.alpha = 0

        }
    }
    var userData : PostLoginVars?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "My Wallet"
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView()
        tableView.bounces = false 
        gettingWalletData()
    }
    
    func gettingWalletData() {
        self.loading()
        m_WalletData.getWalletData { [weak self ] (data) in
            guard data.2 else {
                self?.failedGettingRequest()
                return
            }
            guard let userData  = data.1 else { self?.failedGettingRequest() ; return }
            self?.userData = userData
            guard let walletData  = data.0 else {
                DispatchQueue.main.async {
                    self?.view.showSimpleAlert("Your Wallet is Empty", "", .notification)
                    self?.killLoading()
                }
                return }
            DispatchQueue.main.async {
                self?.cardsData = walletData
                self?.tableView.reloadData()
                self?.killLoading()
            }
            
            
        }
    }
    func failedGettingRequest() {
        DispatchQueue.main.async {
            self.view.showSimpleAlert("Something went wrong!!", "Couldn't get Wallet Data, Please try again!!", .warning)
            self.killLoading()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = RedeemedCodeVC()
        vc.imageLink = cardsData[indexPath.row].qr_path
        vc.qrCodeValue = cardsData[indexPath.row].value
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WalletCellId", for: indexPath) as! MyWalletCell
        cell.configCell(cardsData[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90 
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
