//
//  CustomTextField.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 18/04/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        setKeyBoardDone()
    }
    
    func setKeyBoardDone(){
        let numberToolbar: UIToolbar = UIToolbar()
        
        let barItiem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(CustomTextField.doneBttnTapped(_:)))
        barItiem.tintColor = Constants.APP_TEXT_COLOR
        
        numberToolbar.barStyle = UIBarStyle.default
//        numberToolbar.barStyle = UIBarStyle.blackTranslucent
        numberToolbar.items=[
            //            UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Bordered, target: self, action: "hoopla"),
            
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil),
            barItiem
            
        ]
        
        numberToolbar.sizeToFit()
        
        self.inputAccessoryView = numberToolbar
    }
    
    func doneBttnTapped(_ sender : Any){
        self.resignFirstResponder()
    }

}

class ExpiryDateTextFeild : UITextField , UITextFieldDelegate{
    
    override func awakeFromNib() {
//        setKeyBoardDone()
        super.awakeFromNib()
        self.delegate = self
    }
    
//    override public var text: String? {
//        didSet {
//            if let tex = text , !isEditing{
//               super.text = UtilsSwift.changeToPhoneFormat(string: tex)
//            }
//            
//        }
//    }

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let str = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if textField == self{
            
            return checkEnglishPhoneNumberFormat(string: string, str: str)
            
        }else{
            
            return true
        }
    
    
    }
    func checkEnglishPhoneNumberFormat(string: String?, str: String?) -> Bool{
        
        if string == ""{ //BackSpace
            
            return true
            
//        }else if str!.characters.count < 3{
//            
//            if str!.characters.count == 1{
//                
//                self.text = "/"
//            }
            
        }else if str!.characters.count == 3{
            
            self.text = self.text! + "/"
            
//        }else if str!.characters.count == 10{
//            
//            self.text = self.text! + "-"
        
        }else if str!.characters.count > 7{
            
            return false
        }
        
        return true
    }
    
    
}
class CVVTextFeild : UITextField , UITextFieldDelegate{
    
    override func awakeFromNib() {
        //        setKeyBoardDone()
        super.awakeFromNib()
        self.delegate = self
    }
    
    //    override public var text: String? {
    //        didSet {
    //            if let tex = text , !isEditing{
    //               super.text = UtilsSwift.changeToPhoneFormat(string: tex)
    //            }
    //
    //        }
    //    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let str = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if textField == self{
            
            return checkEnglishPhoneNumberFormat(string: string, str: str)
            
        }else{
            
            return true
        }
        
        
    }
    func checkEnglishPhoneNumberFormat(string: String?, str: String?) -> Bool{
        
//        if string == ""{ //BackSpace
//            
//            return true
//            
//            //        }else if str!.characters.count < 3{
//            //
//            //            if str!.characters.count == 1{
//            //
//            //                self.text = "/"
//            //            }
//            
//        }else if str!.characters.count == 3{
//            
//            self.text = self.text! + "/"
//            
//            //        }else if str!.characters.count == 10{
//            //
//            //            self.text = self.text! + "-"
//            
//        }else
            if str!.characters.count > 3{
            
            return false
        }
        
        return true
    }
    
    
}

