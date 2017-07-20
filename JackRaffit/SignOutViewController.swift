//
//  SignOutViewController.swift
//  JackRaffit
//
//  Created by Kuldeep Butola on 29/06/17.
//  Copyright © 2017 Hooman. All rights reserved.
//

import UIKit

class SignOutViewController: BaseViewController {

    @IBOutlet weak var txtPassword : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    override func backTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func signOutTapped(_ sender : UIButton) {
        
        if validation() {
            UserDefault.signOut()
            performSegue(withIdentifier: "unwind", sender: nil)
        }
        
    }
    
    func validation () -> Bool {
        
        if Utils.check(forEmpty: txtPassword.text) {
            Utils.showAlert(withMessage: Constants.VALID_PASSWORD, andTitle: Constants.TITLE_ALERT)
            return false
        }else if (txtPassword.text != UserDefault.getPassword()){
            Utils.showAlert(withMessage: Constants.VALID_PASSWORD, andTitle: Constants.TITLE_ALERT)
            return false
        }
        
        return true
    }

}
