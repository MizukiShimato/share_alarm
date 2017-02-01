//
//  User.swift
//  share_alarm
//
//  Created by suzukiryota on 2017/02/02.
//  Copyright © 2017年 Mizuki Shimato. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth


//email -> username兼id
class Me {
    let name: String?
    let id: String?
    static func instance() -> Me {
       // FIRAuth.auth()?.currentUser.
        //let email = FIRAuth.auth()?.currentUser?.email
        return Me(name: "mizuki", id: "mizuki")
    }
    
    private init(name: String?, id: String?) {
        self.name = name
        self.id = id
    }
}
