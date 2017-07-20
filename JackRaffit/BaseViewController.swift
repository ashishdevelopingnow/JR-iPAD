//
//  BaseViewController.swift
//  JackRaffit
//
//  Created by Jack on 23/05/17.
//  Copyright © 2017 Hooman. All rights reserved.
//

import UIKit

class BaseViewController : UIViewController {

    var HUD : MBProgressHUD?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backTapped(_ sender : AnyObject){
        let _ = self.navigationController?.popViewController(animated: true)
    }

    // MARK: - HUD methods
    func showHudWithMessage(_ message : String){
        HUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        HUD?.label.text = Utils.check(forEmpty: message) == true ? "Please Wait" : message
    }
    func hideHud () {
        HUD?.hide(animated: true)
    }
    
    //MARK: refresh
    func addRefreshViewInTable(_ tableView : UITableView){
        let refreshController = UIRefreshControl()
        //        UIControlEventValueChanged
        refreshController.addTarget(self, action: #selector(BaseViewController.refreshTable(_:)), for: .valueChanged)
        tableView.addSubview(refreshController)
    }
    //MARK: override methods
    func refreshTable(_ sender : UIRefreshControl){
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
