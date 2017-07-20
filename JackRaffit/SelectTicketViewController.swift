//
//  SelectTicketViewController.swift
//  JackRaffit
//
//  Created by Jack on 23/05/17.
//  Copyright © 2017 Hooman. All rights reserved.
//

import UIKit

class SelectTicketViewController: BaseViewController {

    @IBOutlet var bttn1 : UIButton!
    @IBOutlet var bttn2 : UIButton!
    @IBOutlet var bttn3 : UIButton!
    
    @IBOutlet var lblPrice1 : UILabel!
    @IBOutlet var lblPrice2 : UILabel!
    @IBOutlet var lblPrice3 : UILabel!
    
    @IBOutlet var lblTicket1 : UILabel!
    @IBOutlet var lblTicket2 : UILabel!
    @IBOutlet var lblTicket3 : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInititlaUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setInititlaUI () {
        setSelectedOff()
        bttn1?.isSelected = true
        
        if let appdel = UIApplication.shared.delegate as? AppDelegate , let ticketType = appdel.selectedRaffle?.ticketType , ticketType.count == 3 {
            
             let firstTicket = ticketType[0]
            let secondTicket = ticketType[1]
            let thirdtTicket = ticketType[2]
//            let forthTicket = ticketType[3]
            print("happy")
            
            lblPrice1.text = "$" + (firstTicket.price ?? "")
            lblPrice2.text = "$" + (secondTicket.price ?? "")
            lblPrice3.text = "$" + (thirdtTicket.price ?? "")
            lblTicket1.text = (firstTicket.tickets ?? "") + " tickets"
            lblTicket2.text = (secondTicket.tickets ?? "") + " tickets"
            lblTicket3.text = (thirdtTicket.tickets ?? "") + " tickets"
            
            
        }
    }
    
    @IBAction func buttonTapped(_ sender : UIButton){
        
        setSelectedOff()
        sender.isSelected = true
        
    }
    func setSelectedOff () {
        bttn1.isSelected = false
        bttn2.isSelected = false
        bttn3.isSelected = false
    }

    func getPriceAndTicket () -> (String , String , TicketType?){
        if let appdel = UIApplication.shared.delegate as? AppDelegate , let ticketType = appdel.selectedRaffle?.ticketType , ticketType.count == 3 {
            
            let firstTicket = ticketType[0]
            let secondTicket = ticketType[1]
            let thirdtTicket = ticketType[2]
            
            if bttn1.isSelected {
                return (firstTicket.price ?? "" , firstTicket.tickets ?? "" , firstTicket)
            }else if bttn2.isSelected {
                return (secondTicket.price ?? "" , secondTicket.tickets ?? "" , secondTicket)
            }else if bttn3.isSelected {
                return (thirdtTicket.price ?? "" , thirdtTicket.tickets ?? "" ,thirdtTicket)
            }
        }
        return ("" , "" , nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "next" {
            let viewCnt = segue.destination as? PurchaseSummaryViewController
            let (price,ticket,ticketTp) = getPriceAndTicket()
            viewCnt?.price = price
            viewCnt?.ticket = ticket
            viewCnt?.ticketType = ticketTp
        }
    }
 

}
