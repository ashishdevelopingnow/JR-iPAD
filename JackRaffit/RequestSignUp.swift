//
//  RequestSignUp.swift
//  Security Horse
//
//  Created by Jack on 04/01/17.
//  Copyright © 2017 Jack. All rights reserved.
//

import UIKit

extension RequestClass{

    

    
    static func signInWithFb(_ fb_id : String ,first_name : String,last_name : String, email : String,result :  Completion?){
        //        http://35.166.163.212/apis/signin
        //        Params :
        //        {"email":"pravesh@developingnow.com","password":"123456"}
        let dict =
            [
                "email" : email,
                "fb_id" : fb_id,
                "first_name" : first_name,
                "last_name" : last_name
        ]
        let url = apis.baseURL + apis.signInFb
        
        hitServerWith(false,urlString:url, parameters: dict as [String : AnyObject]?) { (response, error, success) -> () in
            print("sucessss     :::::::: \(success)")
            
            guard success == true else {
                
                result?(response, error, false)
                return
            }
            if let dict = response as? [String : AnyObject] {
                if let dict2 = dict["data"]?["User"] as? [String : AnyObject] {
                    UserDefault.saveUserInfo(dict2)
                    UserDefault.loginWithFB(true)
                    //                    if let message = dict["message"] as? String{
                    ////                        UIApplication.shared.keyWindow?.makeToast(message)
                    ////                        UtilsSwift.showAlertWithMessage(message, nil)
                    ////                        Utils.showAlert(withMessage: message,andTitle: nil)
                    //                    }
                    result?(response, error, success)
                    return
                }else  if let message = dict["message"] as? String{
                    
                    UtilsSwift.showAlertWithMessage(message, nil)
                    result?(nil, error, false)
                    return
                }
                
                result?(response, error, success)
                
            }
            result?(response, error, false)
            
        }
        
        
    }
    
    static func signInWith(_ email : String ,password : String, result :  Completion?){
//        http://35.166.163.212/apis/signin
//        Params :
//        {"email":"pravesh@developingnow.com","password":"123456"}
        let dict =
        [
            "email" : email,
            "password" : password
        ]
        let url = apis.baseURL + apis.signIn
        
        hitServerWith(false,urlString:url, parameters: dict as [String : AnyObject]?) { (response, error, success) -> () in
            print("sucessss     :::::::: \(success)")
            
            guard success == true else {
                
                result?(response, error, false)
                return
            }
            if let dict = response as? [String : AnyObject] {
                if let dict2 = dict["data"] as? [String : AnyObject] {
                    UserDefault.saveUserInfo(dict2)
                    UserDefault.loginWithFB(false)
//                    if let message = dict["message"] as? String{
////                        UIApplication.shared.keyWindow?.makeToast(message)
////                        UtilsSwift.showAlertWithMessage(message, nil)
////                        Utils.showAlert(withMessage: message,andTitle: nil)
//                    }
                    result?(response, error, success)
                    return
                }else  if let message = dict["message"] as? String{
                   
                        UtilsSwift.showAlertWithMessage(message, nil)
                    result?(nil, error, false)
                    return
                }
                
                result?(response, error, success)
                
            }
            result?(response, error, false)
            
        }
        
        
    }
    
    
    static func gettingStartWithEmail(_ email : String , result :  Completion?){
        //        http://35.166.163.212/apis/signin
        //        Params :
        //        {"email":"pravesh@developingnow.com","password":"123456"}
        let dict =
            [
                "email" : email,
                
        ]
        let url = apis.baseURL + apis.gettingStartWithEmail
        
        hitServerWith(false,urlString:url, parameters: dict as [String : AnyObject]?) { (response, error, success) -> () in
            print("sucessss     :::::::: \(success)")
            
            guard success == true else {
                
                result?(response, error, false)
                return
            }
            if let dict = response as? [String : AnyObject] {
                if let dict2 = dict["data"] as? [String : AnyObject] {
//                    UserDefault.saveUserInfo(dict2)
                    (UIApplication.shared.delegate as? AppDelegate)?.selectedEmail = email
                    
                    //                    if let message = dict["message"] as? String{
                    ////                        UIApplication.shared.keyWindow?.makeToast(message)
                    ////                        UtilsSwift.showAlertWithMessage(message, nil)
                    ////                        Utils.showAlert(withMessage: message,andTitle: nil)
                    //                    }
                    result?(response, error, success)
                    return
                }else  if let message = dict["message"] as? String{
                    
                    UtilsSwift.showAlertWithMessage(message, nil)
                    result?(nil, error, false)
                    return
                }
                
                result?(response, error, success)
                
            }
            result?(response, error, false)
            
        }
        
        
    }

   
    
    
    

}
