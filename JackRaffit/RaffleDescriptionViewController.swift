//
//  RaffleDescriptionViewController.swift
//  JackRaffit
//
//  Created by Kuldeep on 29/07/17.
//  Copyright © 2017 Hooman. All rights reserved.
//

import UIKit

class RaffleDescriptionViewController: BaseViewController {

 //   lbl
    @IBOutlet weak var imageView1 : UIImageView!
    @IBOutlet weak var imageView2 : UIImageView!
    @IBOutlet weak var imageView3 : UIImageView!
    
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblSubTitle : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let raffle = (UIApplication.shared.delegate as? AppDelegate)?.selectedRaffle {
            
            if let priseArray = raffle.prizesArray {
                if priseArray.count == 1 , let imageuRL = priseArray[0].prize_image , let img = NSURL.init(string: imageuRL)  {
                    imageView1.af_setImage(withURL: img as URL)
                }else if priseArray.count == 2 , let imageuRL1 = priseArray[0].prize_image , let img = NSURL.init(string: imageuRL1) , let imageuRL2 = priseArray[1].prize_image , let img2 = NSURL.init(string: imageuRL2) {
                    imageView2.af_setImage(withURL: img as URL)
                    imageView3.af_setImage(withURL: img2 as URL)
                }
            }
            
            lblTitle.text = raffle.raffles?.benefit_title
            lblSubTitle.text = raffle.raffles?.organization_name
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
