//
//  AlarmListCell.swift
//  share_alarm
//
//  Created by suzukiryota on 2017/03/26.
//  Copyright © 2017年 Mizuki Shimato. All rights reserved.
//

import Foundation
import UIKit
class AlarmListCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBAction func onTapShare(_ sender: UIButton) {
    }
    
    
    var alarm: Alarm?
    func setAlarm(alarm: Alarm) {
        self.alarm = alarm
        title.text = alarm.title
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale!
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        if let time = alarm.time {
            dateLabel?.text = dateFormatter.string(from: time)
        }
    }
}
