//
//  HelloSwiftApplication.swift
//  JackRaffit
//
//  Created by Kuldeep on 01/08/17.
//  Copyright © 2017 Hooman. All rights reserved.
//

import Foundation
import Foundation

class MyApplication:  UIApplication {
    override func sendEvent(_ event:  UIEvent){
        //   let tlfApplicationHelperObj =  TLFApplicationHelper()
        //   tlfApplicationHelperObj.sendEvent(event)
        super.sendEvent(event)
    }
    //   override func sendAction(action:  Selector, to target:
    //       AnyObject!, from sender:  AnyObject!,
    //                   forEvent event:  UIEvent!) ->  Bool{
    //     let tlfApplicationHelperObj =  TLFApplicationHelper.sharedInstance()
    //      tlfApplicationHelperObj.sendAction(action, to:
    
}

@objc(HelloSwiftApplication) class HelloSwiftApplication : UIApplication {
    
    override func sendEvent(_ event: UIEvent) {
        //
        // Ignore .Motion and .RemoteControl event
        // simply everything else then .Touches
        //
        if event.type != .touches {
            super.sendEvent(event)
            return
        }
        
        (UIApplication.shared.delegate as? AppDelegate)?.timmerViewCnt?.resetTimmer()
        
        //
        // .Touches only
        //
  /*      var restartTimer = true
        
        if let touches = event.allTouches {
            //
            // At least one touch in progress?
            // Do not restart auto lock timer, just invalidate it
            //
            for touch in touches.enumerated() {
                if touch.element.phase != .cancelled && touch.element.phase != .ended {
                    restartTimer = false
                    break
                }
            }
        }
        
        if restartTimer {
            // Touches ended || cancelled, restart auto lock timer
            print("Restart auto lock timer")
        } else {
            // Touch in progress - !ended, !cancelled, just invalidate it
            print("Invalidate auto lock timer")
        }
        
 */
        super.sendEvent(event)
    }
    
}
