//
//  RaffleListingViewController.swift
//  JackRaffit
//
//  Created by Jack on 06/06/17.
//  Copyright © 2017 Hooman. All rights reserved.
//

import UIKit

class RaffleListingViewController: BaseViewController , UITableViewDataSource , UITableViewDelegate, FCAlertViewDelegate{

    
    var tableData = [[String : Any]]()
    
    var selectedData : [String : Any]?
    
    @IBOutlet weak var raffleListTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        raffleListTableView.delegate = self
        raffleListTableView.dataSource = self
        
        raffleListTableView.rowHeight = UITableViewAutomaticDimension
        raffleListTableView.estimatedRowHeight = 75.0
        
        addRefreshViewInTable(raffleListTableView)
        requestForRaffleList(completion: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func refreshTable(_ sender: UIRefreshControl) {
        requestForRaffleList { 
            sender.endRefreshing()
        }
    }
    override func backTapped(_ sender: AnyObject) {
        UserDefault.signOut()
//        super.backTapped(sender)
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    func requestForRaffleList(completion : (()->Void)?){
        RequestClass.getRaffleList { (obj, err, finish) in
            completion?()
            if let dd = obj as? [String : Any], var data = dd["data"] as? [[String : Any]] {
                data.reverse()
                self.tableData.removeAll()
                self.tableData.append(contentsOf: data)
                self.raffleListTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    //MARK : UITableViewDelegate datasaource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ?? UITableViewCell.init(style: .subtitle, reuseIdentifier: identifier)
        let dict = tableData[indexPath.row]
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 25)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 22)
        
        cell.detailTextLabel?.numberOfLines = 0
//        cell.layoutIfNeeded()
        
        cell.textLabel?.text = dict["benefit_title"] as? String ?? " "
        
        var str = dict["raffle_ctgry_name"] as? String ?? " "
//        str = str + "\nStart Date : " + (dict["start_date"] as? String ?? "")
//        str = str + "\nEnd Date : " + (dict["end_date"] as? String ?? "")
        
//        "benefit_title" = "2017 Calendar Raffle";
//        "convenience_fee" = "1.00";
//        created = "2016-11-21 22:35:58";
//        "end_date" = "2017-08-01 23:59:00";
//        id = 434;
//        "organization_name" = "Ridgewood Rotary Foundation, Inc";
//        "raffle_ctgry_name" = RotaryClub;
//        "raffle_initial" = RotaryClub;
//        "raffle_type_id" = 7;
//        "start_date" = "2016-11-22 00:00:00";
//        "user_id" = 1492;
//        "winner_reveal_time" = 5;
        
        
        
        cell.detailTextLabel?.text = str
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedData = tableData[indexPath.row]
        
        let fcAlert = FCAlertView.init()
        let image = UIImage(named: "headerLogo")
        fcAlert.delegate = self
        fcAlert.showAlert(inView: ((UIApplication.shared.keyWindow?.rootViewController as! UINavigationController).visibleViewController)!, withTitle: title ?? Constants.APP_NAME, withSubtitle: Constants.ALERT_SELECT_RAFFLE, withCustomImage: image, withDoneButtonTitle: "CONFIRM", andButtons: ["CANCEL"])
    }
    
    
    //MARK : FCAlertViewdelegate
    func alertView(alertView: FCAlertView, clickedButtonIndex index: Int, buttonTitle title:String){
        
    }
    func FCAlertDoneButtonClicked(alertView: FCAlertView){
        
        RequestClass.getRaffleDetails(raffleId: self.selectedData?["id"] as? String) { (obj, err, done) in
            
            if done  {
                self.performSegue(withIdentifier: "next", sender: obj)
            }
            
        }
        
    }
    
//    override func backTapped(_ sender: AnyObject) {
//        let fcAlert = FCAlertView.init()
//        fcAlert.showAlert(inView: self, withTitle: Constants.APP_NAME, withSubtitle: "", withCustomImage: <#T##UIImage?#>, withDoneButtonTitle: <#T##String?#>, andButtons: <#T##[String]?#>)
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
