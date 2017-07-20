//
//  PurchasedViewController.swift
//  JackRaffit
//
//  Created by Kuldeep Butola on 07/07/17.
//  Copyright © 2017 Hooman. All rights reserved.
//

import UIKit

class PurchasedViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var lblPrice1 : UILabel!
    @IBOutlet var lblPrice2 : UILabel!
    @IBOutlet var lblPrice3 : UILabel!
    
    @IBOutlet var lblTicket1 : UILabel!
    @IBOutlet var lblTicket2 : UILabel!
    @IBOutlet var lblTicket3 : UILabel!
    
    @IBOutlet weak var ticketsCollectionView: UICollectionView!
    @IBOutlet weak var lblTitle : UILabel!
    var ticketSetArray : Array<String>?
    override func viewDidLoad() {
        super.viewDidLoad()

        let yourAttributes = [NSForegroundColorAttributeName: UIColor.init(colorLiteralRed: 199/255.0, green: 207/255.0, blue: 224/255.0, alpha: 1), NSFontAttributeName: UIFont.systemFont(ofSize: 24)]
        let yourOtherAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: 26)]
        
        let partOne = NSMutableAttributedString(string: "Tickets has been emailed to ", attributes: yourAttributes)
        let partTwo = NSMutableAttributedString(string: (UIApplication.shared.delegate as? AppDelegate)?.selectedEmail ?? "" , attributes: yourOtherAttributes)
        
        let combination = NSMutableAttributedString()
        
        combination.append(partOne)
        combination.append(partTwo)
        
        lblTitle.attributedText = combination
//        var attributedString = NSMutableAttributedString(string:"\(calculatedCoffee)")
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

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if(ticketSetArray != nil){
            return ticketSetArray!.count
        }else{
            return 0
        }
        
        
    }
    
    //3

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Configure the cell
        let cell:PurchasedTicketCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "purchasedTicketCell",
                                                                                 for: indexPath) as! PurchasedTicketCollectionViewCell
        let ticket = (ticketSetArray?[indexPath.row])!as String
        cell.lblTicketSet.text = ticket

        return cell
    }
    
    @IBAction func finishButtonTapped(_ sender: Any) {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
}
