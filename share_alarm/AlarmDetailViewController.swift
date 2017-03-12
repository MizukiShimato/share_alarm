//
//  AlarmDetailViewController.swift
//  share_alarm
//
//  Created by suzukiryota on 2017/03/08.
//  Copyright © 2017年 Mizuki Shimato. All rights reserved.
//

import Foundation
import UIKit

class AlarmDetailViewControlle : UIViewController {
    
    @IBOutlet weak var alarmName: UILabel!
    
    @IBOutlet weak var alarmDate: UILabel!
    
    @IBOutlet weak var vibration: UILabel!
    
    var alarm: Alarm? = nil
    
    
    @IBAction func onClickOyasumi(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "SubscribeAlarm", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SubscribeAlarm") as! SubscribeAlarmViewController
        vc.alarm = alarm
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let alarm = alarm {
            alarmName.text = alarm.title
            let dateFormatter = DateFormatter()
            dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale!
            dateFormatter.dateFormat = "MM/dd HH:mm"
            if let time = alarm.time {
                alarmDate.text = dateFormatter.string(from: time)
            }
            if let vib = alarm.vibration {
                vibration.text = vib ? "ON" : "OFF"
            }
        }
    }
}
