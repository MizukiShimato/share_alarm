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
    private static var me: Me?
    static func instance() -> Me {
       // FIRAuth.auth()?.currentUser.
        //let email = FIRAuth.auth()?.currentUser?.email
        return Me.me!
    }
    
    static func set(id: String, name: String) {
        Me.me = Me(name: name, id: id)
    }
    
    private init(name: String?, id: String?) {
        self.name = name
        self.id = id
    }
}
