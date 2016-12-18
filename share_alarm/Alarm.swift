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
}

func initialAlarm() ->Alarm {
    return Alarm()
}
