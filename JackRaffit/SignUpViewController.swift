//
//  SignUpViewController.swift
//  JackRaffit
//
//  Created by Jack on 23/05/17.
//  Copyright © 2017 Hooman. All rights reserved.
//

import UIKit

class SignUpViewController: BaseViewController {

    @IBOutlet weak var txtEmail : UITextField!
    @IBOutlet weak var txtPassword : UITextField!
    
    
    @IBOutlet weak var overLayView : UIView!
    
    @IBOutlet weak var lblTitle : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let sampleText = "Login to your JackRaffit account to select the raffle you'd like to run on this tablet. If you don't already have an account go to www.jackraffit.com to register and create your first raffle."
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.justified
        
        let attributedString = NSAttributedString(string: sampleText,
                                                  attributes: [
                                                    NSParagraphStyleAttributeName: paragraphStyle,
                                                    NSBaselineOffsetAttributeName: NSNumber(value: 0)
            ])
        lblTitle.attributedText = attributedString
       // lblTitle.textAlignment = .center
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefault.getUserInfo() == nil {
            overLayView.isHidden = true
        }else{
            overLayView.isHidden = false
            self.perform(#selector(SignUpViewController.nextScreen), with: nil, afterDelay: 0.1)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signInTapped (_ sender : UIButton) {
        
        if validation() == false {
            return
        }
        self.view.endEditing(true)
        self.showHudWithMessage("")
        RequestClass.signInWith(txtEmail.text ?? "", password: txtPassword.text ?? "") { (obj, err, finish) in
            self.hideHud()
            if finish {
                UserDefault.setPassword(self.txtPassword.text)
                self.nextScreen()
            }
        
        }
    }
    
    
    @IBAction func facebookSignIn (_ sender : UIButton) {
        FacebookModel.getDataFromFB(self) { (obj) in
            if let data = obj as? [String : Any] {
                print("sadasa %@",data)
                self.showHudWithMessage("")
                RequestClass.signInWithFb(data["id"] as? String ?? "", first_name: data["first_name"] as? String ?? "", last_name: data["last_name"] as? String ?? "", email: data["email"] as? String ?? "", result: { (obj, err, finish) in
                    self.hideHud()
                    if finish {
                        UserDefault.setPassword(self.txtPassword.text)
                        self.nextScreen()
                    }
                    
                })
                
            }
        }
    }
    
    func nextScreen() {
        if let appdelegate = UIApplication.shared.delegate as? AppDelegate, let raffle = UserDefault.getSelectedRaffle() {
            appdelegate.selectedRaffle = raffle
             self.performSegue(withIdentifier: "signIn1", sender: nil)
         return
        }
        self.performSegue(withIdentifier: "signIn", sender: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func validation () -> Bool {
        
        if !Utils.validateEmail(txtEmail.text) {
            Utils.showAlert(withMessage: Constants.VALID_EMAIL_ID, andTitle: Constants.TITLE_ALERT)
            return false
        }else if Utils.check(forEmpty: txtPassword.text) {
            Utils.showAlert(withMessage: Constants.VALID_PASSWORD, andTitle: Constants.TITLE_ALERT)
            return false
        }
        
        return true
    }
      // MARK: - UnWind segue
    
    @IBAction func signOutTapped(_ segue : UIStoryboardSegue){
        
    }
    
}
