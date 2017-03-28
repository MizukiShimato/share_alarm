//
//  AlarmConfirmViewController.swift
//  share_alarm
//
//  Created by suzukiryota on 2017/03/11.
//  Copyright © 2017年 Mizuki Shimato. All rights reserved.
//

import Foundation
import UIKit

class AlarmConfirmViewController : UIViewController, AlarmCreateShare {
    @IBOutlet weak var musicTitle: UILabel!
    @IBOutlet weak var alarmTitle: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var vibLabel: UILabel!
    
    @IBAction func onTapSendAlarm(_ sender: UIButton) {
        self.sendAlarm(alarm) { alarmIdToken in
            self.share(alarmTokenId: alarmIdToken)
        }
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    func viewInit() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale!
        dateFormatter.dateFormat = "MM/dd HH:mm"
        if let time = alarm.time {
            dateLabel.text = dateFormatter.string(from: time)
        }
        if let vib = alarm.vibration {
            vibLabel.text = vib ? "オン" : "オフ"
        }
        musicTitle.text = selectedMusicTitle
        alarmTitle.text = alarm.title
        
    }

    
    func sendAlarm(_ alarm : Alarm, cb: @escaping (String) -> Void) {
        let instance = AlarmService.instance()
        instance.store(alarm) { id in
            cb("\(id)@\(Me.instance().id!)")
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        viewInit()
    }
    
    override func viewDidLoad() {
        viewInit()
    }
}
