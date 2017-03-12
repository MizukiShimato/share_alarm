//
//  JoinedUserList.swift
//  share_alarm
//
//  Created by suzukiryota on 2017/03/12.
//  Copyright © 2017年 Mizuki Shimato. All rights reserved.
//

import Foundation
import UIKit

class JoinedUserList: UITableView {
    var users: [JoinedUser] = []
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        let cell = UINib(nibName: "JoinedUserCellView", bundle: nil)
        self.register(cell, forCellReuseIdentifier: "JoinedUserCell")
        self.dataSource = self
    }
}


extension JoinedUserList:  UITableViewDataSource {
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let cell = self.dequeueReusableCell(withIdentifier: "JoinedUserCell") as! JoinedUserCell
        cell.setUser(user: user)
        return cell
    }
}
