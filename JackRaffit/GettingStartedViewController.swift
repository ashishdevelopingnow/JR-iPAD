//
//  GettingStartedViewController.swift
//  JackRaffit
//
//  Created by Kuldeep Butola on 04/07/17.
//  Copyright © 2017 Hooman. All rights reserved.
//

import UIKit

class GettingStartedViewController : BaseViewController {//, UICollectionViewDelegate , UICollectionViewDataSource{

    @IBOutlet weak var txtEmail : UITextField!
    
//    @IBOutlet weak var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        collectionView.delegate = self
//        collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func gettingStartedTapped (_ sender : UIButton) {
        if validation() {
            self.view.endEditing(true)
            self.showHudWithMessage("")
            RequestClass.gettingStartWithEmail(txtEmail.text ?? "", result: { (obj, err, comp) in
                self.hideHud()
//                asdsa
                if comp {
                    self.performSegue(withIdentifier: "next", sender: nil)
                }
                
            })
        }
    }

    func validation () -> Bool {
        
        if !Utils.validateEmail(txtEmail.text) {
            Utils.showAlert(withMessage: Constants.VALID_EMAIL_ID, andTitle: Constants.TITLE_ALERT)
            return false
        }
        
        return true
    }
    
    // MARK: - Navigation
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
