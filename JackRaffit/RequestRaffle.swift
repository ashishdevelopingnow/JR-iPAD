//
//  RequestRaffle.swift
//  JackRaffit
//
//  Created by Jack on 06/06/17.
//  Copyright © 2017 Hooman. All rights reserved.
//

import Foundation

//
//  ProfileRequest.swift
//  Security Horse
//
//  Created by Jack on 02/03/17.
//  Copyright © 2017 Jack. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

extension RequestClass{
    static func getRaffleList(result :  Completion?){
        
       
        
        
       
//        print("dict === ",dict)
        let url = apis.baseURL + apis.listOfRaffle
        
        
        hitServerWith(true,urlString:url, parameters: nil) { (response, error, success) -> () in
            print("sucessss     :::::::: \(success)")
//            defer {
//                result?(response, error, success)
//            }
            
            guard success == true else {
                                result?(response, error, false)
                return
            }
            if let dict = response as? [String : AnyObject] {
                if let dict2 = dict["data"] as? [String : AnyObject]{
                    
                    
                    UserDefault.setGettingStartedEmailInfo(dict2)
                    
//                    UserDefault.saveUserInfo(dict2)
                    
                    //                    if let message = dict["message"] as? String{
                    //                        UtilsSwift.showAlertWithMessage(message, nil)
                    ////                        Utils.showAlert(withMessage: message,andTitle: nil)
                    //                    }
                    
                    
                                        result?(response, error, success)
                    return
                }
            }
            
            result?(response, error, false)
           
        }
    }
    
    static func getRaffleDetails(raffleId : String? , result :  Completion?){
        
        
        
        
        
        //        print("dict === ",dict)
        let url = apis.baseURL + apis.detailOfRaffle
        let dict : [String : AnyObject] = [
            "raffle_id" : raffleId as AnyObject!
        ]
        
        hitServerWith(true,urlString:url, parameters: dict) { (response, error, success) -> () in
            print("sucessss     :::::::: \(success)")
//            defer {
//                result?(response, error, success)
//            }
            
            guard success == true else {
                result?(response, error, false)
                return
            }
            if let dict = response as? [String : AnyObject] {
                if let dict2 = dict["data"] as? [String : AnyObject]{
                    UserDefault.saveRaffleInfo(dict2)
                    
                    let mapper = Mapper<Raffle>().map(JSONObject: dict2)
                    
                    (UIApplication.shared.delegate as? AppDelegate)?.selectedRaffle = mapper
                    result?(mapper,error,true)
                    
                    
                    return
                }
            }
            
            result?(response, error, success)
            
        }
    }

    
    
    static func payRaffle(raffleId : String ,cost : String, ticket_type_id : String, token_id : String, result :  Completion?){
        
        
        
        
        
        //        print("dict === ",dict)
//        let url = apis.baseURL + apis.raffitPayment
        let url = "http://stage.jackraffit.com/apis/" + apis.raffitPayment
        let dict : [String : AnyObject] = [
            "raffle_id" : raffleId as AnyObject,
            "cost" : cost as AnyObject,
            "ticket_type_id" : ticket_type_id  as AnyObject,
            "token_id" : token_id  as AnyObject
            
        ]
        
        print("dict :::::  %@",dict)
//            {"raffle_id":"","cost":"without convenience fee", "ticket_type_id": "selected ticket type id", "token_id":""}
//        http://stage.jackraffit.com/apis/ipad_stripe_payment
        
        hitServerWith(true,urlString:url, parameters: dict) { (response, error, success) -> () in
            print("sucessss     :::::::: \(success)")
            //            defer {
            //                result?(response, error, success)
            //            }
            
            guard success == true else {
                result?(response, error, false)
                return
            }
            if let dictt = response as? [String : AnyObject] {
                if let dict2 = dict["data"] as? [String : AnyObject]{
                    UserDefault.saveRaffleInfo(dict2)
                    
                    let mapper = Mapper<Raffle>().map(JSONObject: dict2)
                    
                    (UIApplication.shared.delegate as? AppDelegate)?.selectedRaffle = mapper
                    result?(mapper,error,true)
                    result?(dictt as AnyObject,error,true)
                    
                    return
                }
            }
            
            result?(response, error, success)
            
        }
    }
    
    
}
