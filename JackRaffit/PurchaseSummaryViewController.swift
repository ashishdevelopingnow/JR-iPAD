//
//  PurchaseSummaryViewController.swift
//  JackRaffit
//
//  Created by Jack on 31/05/17.
//  Copyright © 2017 Hooman. All rights reserved.
//

import UIKit

class PurchaseSummaryViewController: BaseViewController {

    @IBOutlet weak var lblRaffleName : UILabel!
    @IBOutlet weak var lblDrawDate : UILabel!
    @IBOutlet weak var lblDrawTime : UILabel!
    
    @IBOutlet weak var lblConvenience : UILabel!
    @IBOutlet weak var lblTotle : UILabel!
    
    @IBOutlet weak var lblPrice : UILabel!
    
    @IBOutlet weak var lblSubConvenience : UILabel!
    @IBOutlet weak var lblSubTotle : UILabel!
    
    @IBOutlet weak var lblSubPrice : UILabel!
    
    
    var price : String = ""
    var ticket : String = ""
    var ticketType : TicketType?
    override func viewDidLoad() {
        super.viewDidLoad()

        var convFee = 0
        var priceTic = 0
        
        if let raffle = (UIApplication.shared.delegate as? AppDelegate)?.selectedRaffle {
            lblRaffleName.text = ": " + (raffle.raffles?.benefit_title ?? "")
            lblDrawDate.text = ": " + (raffle.raffles?.draw_time ?? "")
            lblDrawTime.text = ": " + (raffle.raffles?.winner_reveal_time ?? "")
            
            if let rr = raffle.raffles?.convenience_fee , let convFe = Double(rr.trimmingCharacters(in: .whitespaces)){
                
                convFee = Int(convFe)
            }
        }
        
        if let tt = Int(price){
            priceTic = tt
        }
        
        lblPrice.text = "$\(priceTic)"
        lblConvenience.text = "$\(convFee)"
        lblTotle.text = "$\(convFee + priceTic)"
        
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
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "next" {
            let viewCnt = segue.destination as? PurchaseCreditCardViewController
//            let (price,ticket) = getPriceAndTicket()
            viewCnt?.price = price
            viewCnt?.ticket = ticket
            viewCnt?.ticketType = ticketType
        }
    }
    

}
