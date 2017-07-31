//
//  PayWithCashViewController.swift
//  JackRaffit
//
//  Created by Kuldeep on 29/07/17.
//  Copyright © 2017 Hooman. All rights reserved.
//

import UIKit

class PayWithCashViewController: BaseViewController {

    var price : String = ""
    var ticket : String = ""
    var ticketType : TicketType?
    
    @IBOutlet weak var lblTotle : UILabel!
    @IBOutlet weak var lblSubTotle : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        
        lblTotle.text = "$\(convFee + priceTic)"

        if let vl = Int(ticket), vl > 1 {
            lblSubTotle.text = "\(ticket) tickets"
        }else{
            lblSubTotle.text = "\(ticket) ticket"
        }
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

}
