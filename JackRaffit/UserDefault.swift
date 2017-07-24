//
//  UserDefault.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 17/01/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit
import ObjectMapper

class UserDefault: NSObject {

    struct NOTIFICATION {
//        static let Applied_Job = "userappliedForTheJob"
//        static let USER_EMAIL = "userDefaultEmailId"
    }
    struct USER_DEFAULT {
        static let USER_INFO = "userDefaultUsersInformationss"
        static let USER_PASSWORD = "userDefaultforpasswordselection"
        static let SELECTED_RAFFLE_INFO = "userDefaultUsersrafflesInformations"
        
        
        static let GETTING_STARTED_WITH_EMAIL = "gettingstarteddataforemailverify"
//        static let FACEBOOK_DATA = "facebookdata"
//        
//        static let LICENCE_IMAGE = "licenceImage"
//        
//        static let VERIFIED_MOBILE_NO = "userdefaultVarifiedMobileNo"
//        static let IS_VERIFIED_MOBILE_NO = "userdefaultismobilenumberVerified"
    }
    //MARK: - SignOu
    static func signOut(){
        saveUserInfo(nil)
        setPassword(nil)
        saveRaffleInfo(nil)
    }
    
    //MARK: - User details
    static func saveUserInfo(_ data : [String : AnyObject]?) {
        
        Utils.saveData(toUserDefault: data, key: USER_DEFAULT.USER_INFO)
    }
    
    static func saveRaffleInfo(_ data : [String : AnyObject]?) {
        
        Utils.saveData(toUserDefault: data, key: USER_DEFAULT.SELECTED_RAFFLE_INFO)
    }
    static func getUserEmailId() -> String? {
        
        let data = Utils.dataFromUserDefault(forKey: USER_DEFAULT.USER_INFO) as? [String : AnyObject]
        return data?["User"]?["email"] as? String
 //       Utils.saveData(toUserDefault: data, key: USER_DEFAULT.SELECTED_RAFFLE_INFO)
    }
    
    static func getSelectedRaffle () -> Raffle? {
        let data = Utils.dataFromUserDefault(forKey: USER_DEFAULT.SELECTED_RAFFLE_INFO) as? [String : AnyObject]
        let mapper = Mapper<Raffle>().map(JSONObject: data)
        return mapper
        
    }
    
    static func setPassword(_ password : String?)
    {
        Utils.saveData(toUserDefault: password, key: USER_DEFAULT.USER_PASSWORD)
        
    }
    static func getPassword() -> String?
    {
        return Utils.dataFromUserDefault(forKey: USER_DEFAULT.USER_PASSWORD) as? String
    }
    static func getUserInfo() -> Any? {
        return Utils.dataFromUserDefault(forKey: USER_DEFAULT.USER_INFO)
    }
    static func getUserAuthentification() -> Any? {
        let dict = Utils.dataFromUserDefault(forKey: USER_DEFAULT.USER_INFO) as? [String : Any]
        return dict?["access_token"]
    }
    
    static func setGettingStartedEmailInfo(_ info : [String : AnyObject]?)
    {
        Utils.saveData(toUserDefault: info, key: USER_DEFAULT.GETTING_STARTED_WITH_EMAIL)
        
    }
    static func getGettingStartedEmailInfo() -> [String : AnyObject]?
    {
        return Utils.dataFromUserDefault(forKey: USER_DEFAULT.GETTING_STARTED_WITH_EMAIL) as? [String : AnyObject]
    }

    
}
