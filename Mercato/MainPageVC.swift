//
//  MainPageVC.swift
//  Mercato
//
//  Created by Macbook Pro on 8/15/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit

class MainPageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnsSelectionAct(_ sender: UIButton) {
        print(sender.tag)
        
        switch sender.tag {
        case 0 :
            let vc = RegistrationVC()
            self.present(vc, animated: true, completion: nil)
            
         case 4:
            let vc = LocationOnMapVC()
            navigationController?.pushViewController(vc, animated: true)
        default: 
        performSegue(withIdentifier: "ourProductsSegue", sender: self)

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
