//
//  PurchaseCreditCardViewController.swift
//  JackRaffit
//
//  Created by Kuldeep Butola on 06/07/17.
//  Copyright © 2017 Hooman. All rights reserved.
//

import UIKit
import Stripe


class PurchaseCreditCardViewController: BaseViewController,STPAddCardViewControllerDelegate ,PKPaymentAuthorizationViewControllerDelegate{
    /**
     *  This is called when the user successfully adds a card and tokenizes it with Stripe. You should send the token to your backend to store it on a customer, and then call the provided `completion` block when that call is finished. If an error occurred while talking to your backend, call `completion(error)`, otherwise, dismiss (or pop) the view controller.
     *
     *  @param addCardViewController the view controller that successfully created a token
     *  @param token                 the Stripe token that was created. @see STPToken
     *  @param completion            call this callback when you're done sending the token to your backend
     *
     *  @note If you are on Swift 3, you must declare the completion block as `@escaping` or Xcode will give you a protocol conformance error. https://bugs.swift.org/browse/SR-2597
     */
    public func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
        
    }

    /**
     *  Called when the user cancels adding a card. You should dismiss (or pop) the view controller at this point.
     *
     *  @param addCardViewController the view controller that has been cancelled
     */
    public func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        
    }


    @IBOutlet weak var lblConvenience : UILabel!
    @IBOutlet weak var lblTotle : UILabel!
    
    @IBOutlet weak var lblPrice : UILabel!
    
    @IBOutlet weak var lblSubConvenience : UILabel!
    @IBOutlet weak var lblSubTotle : UILabel!
    
    @IBOutlet weak var lblSubPrice : UILabel!
    
    
//    @IBOutlet weak var txtFullName : UITextField!
    @IBOutlet weak var txtCardNumber : UITextField!
    @IBOutlet weak var txtExpiry : UITextField!
    @IBOutlet weak var txtCVV : UITextField!
    @IBOutlet weak var txtBilling : UITextField!
    
    var responseTicketSetArray : Array<String>?
    var price : String = ""
    var ticket : String = ""
    
    var ticketType : TicketType?
    
    var totalPrice = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        STPPaymentConfiguration.shared().appleMerchantIdentifier = "merchant.com.JackRaffit"
        
        var convFee = 0
        var priceTic = 0
        
        if let raffle = (UIApplication.shared.delegate as? AppDelegate)?.selectedRaffle {
            
            if let rr = raffle.raffles?.convenience_fee , let convFe = Double(rr.trimmingCharacters(in: .whitespaces)){
                
                convFee = Int(convFe)
            }
        }
        
        if let tt = Int(price){
            priceTic = tt
        }
        totalPrice = convFee + priceTic
        lblPrice.text = "$\(priceTic)"
        lblConvenience.text = "$\(convFee)"
        lblTotle.text = "$\(totalPrice)"
        
        lblSubConvenience.text = "+ Convenience fee"
        lblSubTotle.text = "= total Cost"
        
        if let vl = Int(ticket), vl > 1 {
            lblSubPrice.text = "Price of \(ticket) tickets"
        }else{
            lblSubPrice.text = "Price of \(ticket) ticket"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func submitTapped(_ sender : UIButton){
//        applePayTapped()
//        return;
//        paymentMethodsButtonTapped()
//        return;
        if validation() {
            pp()
        }
        
    }
    
    func validation() -> Bool{
       /* if Utils.check(forEmpty: txtFullName.text) {
            Utils.showAlert(withMessage: "Please enter full name" , andTitle: Constants.APP_NAME)
            return false
        }else */
            if Utils.check(forEmpty: txtCardNumber.text){
            Utils.showAlert(withMessage: "Please enter valid card number", andTitle: Constants.APP_NAME)
            return false
        }else if Utils.check(forEmpty: txtExpiry.text){
            Utils.showAlert(withMessage:"Please enter 4 digit expiry date" , andTitle:  Constants.APP_NAME)
            return false
        }else if Utils.check(forEmpty: txtCVV.text){
            Utils.showAlert(withMessage:"Please enter 3 digit CVV number" , andTitle: Constants.APP_NAME)
            return false
        }
        return true
    }
    
    func pp() {
        
        
        let cardParams = STPCardParams()
        cardParams.number = txtCardNumber.text
        
        if let expyr = txtExpiry.text {
            
            let arr = expyr.components(separatedBy: "/")
            
            if arr.count > 0 , let month = UInt(arr[0]){
                cardParams.expMonth = month
            }
            if arr.count > 1 , let year = UInt(arr[1]){
                cardParams.expYear = year
            }
            

            
        }
        
        

        cardParams.cvc = txtCVV.text
        
        STPAPIClient.shared().createToken(withCard: cardParams) { (token, error) in
            if let error = error {
                
                Utils.showAlert(withMessage: "", andTitle: error.localizedDescription)
                print(error);
                // show the error to the user
            } else if let token = token {
                
//                STPToken
                print(token.tokenId);
                self.submitPayment(token.tokenId)
//                self.performSegue(withIdentifier: "next", sender: nil)
                
//                Utils.showAlert(withMessage: "Payment completed", andTitle: "")
                
//                self.submitTokenToBackend(token, completion: { (error: Error?) in
//                    if let error = error {
//                        // show the error to the user
//                    } else {
//                        // show a receipt page
//                    }
//                })
            }
        }
    }
    
    func submitPayment(_ token : String) {
        
//        let convFee = 0
        self.showHudWithMessage("")
        if let raffleid = (UIApplication.shared.delegate as? AppDelegate)?.selectedRaffle?.raffles?.id{
            if let ticketType = ticketType {
                RequestClass.payRaffle(raffleId: raffleid, cost: price, ticket_type_id: ticketType.ticket_type_id ?? "", token_id: token) { (obj, err, done) in
                    if done {
                        self.responseTicketSetArray = (obj!["data"] as? [String : AnyObject])?["ticket_set"] as? Array<String>
                        self.performSegue(withIdentifier: "next", sender: nil)
                        self.hideHud()
                    }else{
                        self.hideHud()
                    }
                }
            }
        }
        
    }
    
    func applePayTapped() {
        let paymentRequest = Stripe.paymentRequest(withMerchantIdentifier: "merchant.com.JackRaffit")
        // Configure the line items on the payment sheet
        paymentRequest.paymentSummaryItems = [
            PKPaymentSummaryItem(label: "Fancy hat", amount: NSDecimalNumber(string: "50.00")),
            // the final line should represent your company; it'll be prepended with the word "Pay" (i.e. "Pay iHats, Inc $50")
            PKPaymentSummaryItem(label: "iHats, Inc", amount: NSDecimalNumber(string: "50.00")),
        ]
        if Stripe.canSubmitPaymentRequest(paymentRequest) {
            let paymentAuthorizationVC = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
            paymentAuthorizationVC.delegate = self
            self.present(paymentAuthorizationVC, animated: true, completion: nil)
        } else {
            // there is a problem with your Apple Pay configuration.
        }
        // To be continued
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController,
                                            didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        
        STPAPIClient.shared().createToken(with: payment) { (token, error) in
//            self.submitTokenToBackend(token, completion: { (error: Error?) in
//                if let error = error {
//                    completion(.Failure)
//                } else {
//                    self.paymentSucceeded = true
//                    completion(.Success)
//                }
//            })
        }
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        self.dismiss(animated: true, completion: {
//            if (self.paymentSucceeded) {
//                // show a receipt page
//            }
        })
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "next" {
            let purchasedSumVC = segue.destination as! PurchasedViewController
            purchasedSumVC.ticketSetArray = self.responseTicketSetArray
        }
        
    }
    

}
