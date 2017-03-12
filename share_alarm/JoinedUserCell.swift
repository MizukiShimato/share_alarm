//
//  JoinedUserCell.swift
//  share_alarm
//
//  Created by suzukiryota on 2017/03/12.
//  Copyright © 2017年 Mizuki Shimato. All rights reserved.
//

import Foundation
import UIKit
class JoinedUserCell: UITableViewCell {
    var user: JoinedUser? = nil
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userStatus: UILabel!
    
    func setUser(user: JoinedUser) {
        userName.text = user.name
        userStatus.text = statusToLabel(status: user.status)
    }
    
    private func statusToLabel(status: JoinedUserStatus)-> String {
        switch status {
        case .Joined:
            return "参加済"
        case .Sleeping:
            return "寝ている"
        case .Wokeup:
            return "起きました！"
        }
    }
}
