//
//  AlarmCreateShare.swift
//  share_alarm
//
//  Created by suzukiryota on 2017/03/11.
//  Copyright © 2017年 Mizuki Shimato. All rights reserved.
//

import Foundation
import UIKit
protocol AlarmCreateShare {
    
}
private class SingletonAlarm {
    static var alarm = Alarm.create(time: Date(), dutation: 0, musicURL: "", vibration: true)
    
    static var selectedMusicTitle = ""
}

extension AlarmCreateShare {
    var alarm: Alarm {
        get {
            return SingletonAlarm.alarm
        }
    }
    
    var selectedMusicTitle: String {
        get {
            return SingletonAlarm.selectedMusicTitle
        }
    }
    
    func setMusicTitle(title: String) {
        SingletonAlarm.selectedMusicTitle = title
    }
    
    func initAlarm() {
        SingletonAlarm.alarm = Alarm.create(time: Date(), dutation: 0, musicURL: "", vibration: true)
    }
    
    func setTitle(title: String) {
        SingletonAlarm.alarm.title = title
    }
    
    func setDate(date: Date) {
        SingletonAlarm.alarm.time = date
    }
    
    func setVib(vib: Bool) {
        SingletonAlarm.alarm.vibration = vib
    }
    
    func setMusicUrl(url: String) {
        SingletonAlarm.alarm.musicURL = url
    }
}
