//
//  GettingStartedViewController.swift
//  JackRaffit
//
//  Created by Kuldeep Butola on 04/07/17.
//  Copyright © 2017 Hooman. All rights reserved.
//

import UIKit
import AlamofireImage
class GettingStartedViewController : BaseViewController,FCAlertViewDelegate {//, UICollectionViewDelegate , UICollectionViewDataSource{

    @IBOutlet weak var txtEmail : UITextField!
    
    @IBOutlet weak var imageView1 : UIImageView!
    @IBOutlet weak var imageView2 : UIImageView!
    @IBOutlet weak var imageView3 : UIImageView!
    
    var fcAlert : FCAlertView?
//    @IBOutlet weak var collectionView : UICollectionView!
    var timerForPurchasing : Timer?
    
    var timerForAlert : Timer?
    
    deinit {
        timerForPurchasing?.invalidate()
        timerForPurchasing = nil
        
        timerForAlert?.invalidate()
        timerForAlert = nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        (UIApplication.shared.delegate as? AppDelegate)?.timmerViewCnt = self
        
        if let raffle = (UIApplication.shared.delegate as? AppDelegate)?.selectedRaffle {
            
            if let priseArray = raffle.prizesArray {
                if priseArray.count == 1 , let imageuRL = priseArray[0].prize_image , let img = NSURL.init(string: imageuRL)  {
                    imageView1.af_setImage(withURL: img as URL)
                }else if priseArray.count == 2 , let imageuRL1 = priseArray[0].prize_image , let img = NSURL.init(string: imageuRL1) , let imageuRL2 = priseArray[1].prize_image , let img2 = NSURL.init(string: imageuRL2) {
               imageView2.af_setImage(withURL: img as URL)
                imageView3.af_setImage(withURL: img2 as URL)
                }
            }
        }
        
        
        
        
//        collectionView.delegate = self
//        collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timerForPurchasing?.invalidate()
        timerForPurchasing = nil
        
        timerForAlert?.invalidate()
        timerForAlert = nil
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
        }else if txtEmail.text == UserDefault.getUserEmailId() {
            signOut()
            return false
        }
        
        return true
    }
    
    // MARK: - Navigation
    
    @IBAction func imageViewTapped(_ sender : Any) {
        self.performSegue(withIdentifier: "description", sender: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "next" {
            let cntt = segue.destination as? SelectTicketViewController
            cntt?.emailStr = txtEmail.text
            
            timerForPurchasing = Timer.scheduledTimer(timeInterval: 20, target: self, selector: #selector(self.timer1(_:)), userInfo: nil, repeats: true)
            //resetTimmer()
            
        }
    }
    func resetTimmer () {
        if timerForPurchasing != nil {
            timerForPurchasing?.invalidate()
            timerForPurchasing = nil
            timerForPurchasing = Timer.scheduledTimer(timeInterval: 20, target: self, selector: #selector(self.timer1(_:)), userInfo: nil, repeats: true)
        }
        
    }
    
    func timer1(_ sender : Timer) {
        sender.invalidate()
        timerForPurchasing = nil
        showAlert()
    }
    func timer2(_ sender : Timer) {
        let userInfo = sender.userInfo as! Date
        let interveal = Date().timeIntervalSince(userInfo)
        let seconds = 16 - Int16(interveal)
        fcAlert?.descriptionlbl?.text = "\(seconds) sec"
        if seconds <= 0 {
            fcAlert?.dismissAlertView()
            sender.invalidate()
            self.navigationController?.popToViewController(self, animated: true)
        }
        
        
    }
   
    func showAlert() {
        fcAlert = FCAlertView.init()
        let image = UIImage(named: "headerLogo")
        fcAlert?.delegate = self
        fcAlert?.showAlert(inView: ((UIApplication.shared.keyWindow?.rootViewController as! UINavigationController).visibleViewController)!, withTitle: title ?? Constants.APP_NAME, withSubtitle: "15 sec", withCustomImage: image, withDoneButtonTitle: "Still working?", andButtons: ["Cancel transaction"])
        
        
        timerForAlert = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timer2(_:)), userInfo: NSDate(), repeats: true)
        timerForAlert?.fire()
            //.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timer2(_:)), userInfo: nil, repeats: true)
    }
    
    func signOut(){
        self.performSegue(withIdentifier: "signOut", sender: nil)
        
    }
    
    //MARK : FCAlertViewdelegate
    func alertView(alertView: FCAlertView, clickedButtonIndex index: Int, buttonTitle title:String){
        timerForAlert?.invalidate()
        timerForAlert = nil
        self.navigationController?.popToViewController(self, animated: true)
    }
    func FCAlertDoneButtonClicked(alertView: FCAlertView){
     //   timerForAlert?.invalidate()
     //   timerForAlert = nil
        
   //     timerForPurchasing = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.timer2(_:)), userInfo: nil, repeats: true)
        
        timerForAlert?.invalidate()
        timerForAlert = nil
        timerForPurchasing = Timer.scheduledTimer(timeInterval: 20, target: self, selector: #selector(self.timer1(_:)), userInfo: nil, repeats: true)
        
    }
    
    

}
