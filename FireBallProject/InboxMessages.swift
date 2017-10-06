//
//  InboxMessages.swift
//  FireBallProject
//
//  Created by Chaitanya Pandit on 9/21/17.
//  Copyright © 2017 Chaitanya Pandit. All rights reserved.
//

import UIKit
import Firebase
class InboxMessages: NSObject {
    
    var toID:String? = nil
    var fromID:String? = nil
    var timeStamp: String? = nil
    var text:String? = nil
    var messageImageUrl:String? = nil
    
    func getID() -> String{
        return (fromID == FIRAuth.auth()?.currentUser?.uid ? toID : fromID)!
        
    }

}
