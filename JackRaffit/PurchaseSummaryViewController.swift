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
    
    @IBOutlet weak var lblRaffleClosing : UILabel!
    
    var timer : Timer?
    
    var price : String = ""
    var ticket : String = ""
    var ticketType : TicketType?
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        lblRaffleClosing.text = "Raffle closing in"
        
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
       
        self.startTimer()
        
        
        // Do any additional setup after loading the view.
    }
    
    func startTimer(){
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerTimed(_:)), userInfo: NSDate(), repeats: true)
        timer?.fire()
    }
    
    
    func timerTimed(_ sender : Timer) {
        func stringFromTimeInterval(interval: TimeInterval) -> String {
            let interval = Int(interval)
            let seconds = interval % 60
            let minutes = (interval / 60) % 60
            var hours = (interval / 3600)
            
            if hours > 24 {
                
                let days = hours / 24
                hours = hours % 24
                if days > 1 {
                    return String(format: ": %d days - %02d:%02d:%02d",days, hours, minutes, seconds)
                }
                
                return String(format: ": %d day - %02d:%02d:%02d",days, hours, minutes, seconds)
                
            }
            
            return String(format: ": %02d:%02d:%02d", hours, minutes, seconds)
        }
        
        if let winnerTime = (UIApplication.shared.delegate as? AppDelegate)?.selectedRaffle?.raffles?.draw_time {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            
            let currentDate = dateFormatter.date(from: winnerTime) ?? Date()
            
            let timeInterval = currentDate.timeIntervalSince(Date())
            
            print(".....\(timeInterval)")
            if timeInterval <= 0 {
                sender.invalidate()
                timer = nil
                return ;
            }
            
            lblDrawTime.text = stringFromTimeInterval(interval: timeInterval)
        }
        
       // lblDrawTime.text = ": " + (raffle.raffles?.winner_reveal_time ?? "")
        
        
        
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
        }else if segue.identifier == "payWithCash" {
            let viewCnt = segue.destination as? PayWithCashViewController
            //            let (price,ticket) = getPriceAndTicket()
            viewCnt?.price = price
            viewCnt?.ticket = ticket
            viewCnt?.ticketType = ticketType
        }
    }
    

}
extension Date {
    func toStringFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd yyyy"
        return dateFormatter.string(from: self)
    }
}
