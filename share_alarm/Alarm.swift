//
//  Alarm.swift
//  share_alarm
//
//  Created by Mizuki Shimato on 2016-12-11.
//  Copyright © 2016 Mizuki Shimato. All rights reserved.
//

import Foundation

class Alarm {
    var time: Date?
    var duration: Int?
    var musicURL: String?
    var vibration: Bool?
    var id: String?
    var joiendUsers: [JoinedUser] = []
    //TODO: userId
    
    static func create(time: Date, dutation: Int, musicURL: String, vibration: Bool) -> Alarm {
        let alarm = Alarm()
        alarm.time = time
        alarm.duration = dutation
        alarm.musicURL = musicURL
        alarm.vibration = vibration
        return alarm
    }
    
    func set(id: String) -> Alarm {
        self.id = id
        return self
    }
    
    func toHash() -> [String: Any] {
        let vibration = self.vibration.map({ onOrOff -> Int in
            if onOrOff {
                return 0
            } else {
                return 1
            }
        })
        let key = self.id
        
        var users = [String: Any]()
        
        for user in joiendUsers {
            users[user.id] = user.toHash()
        }
        
        return ["id": key!, "duration": self.duration!, "musicURL": self.musicURL!, "vibration": vibration ?? 0 , "joinedUsers": users, "time": self.time!.timeIntervalSince1970]
    }
}


enum JoinedUserStatus: Int {
    case Joined
    case Sleeping
    case Wokeup
}

class JoinedUser {
    let name: String
    let id: String
    let status: JoinedUserStatus
    
    init(id: String, name: String, status: JoinedUserStatus) {
        self.name = name
        self.id = id
        self.status = status
    }
    
    func toHash() -> [String: Any] {
        return ["id": id, "name": name, "status": status.rawValue]
    }
}

func initialAlarm() ->Alarm {
    return Alarm()
}
