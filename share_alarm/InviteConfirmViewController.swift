//
//  InviteConfirmViewControlelr.swift
//  share_alarm
//
//  Created by suzukiryota on 2017/01/28.
//  Copyright © 2017年 Mizuki Shimato. All rights reserved.
//

import Foundation
import UIKit

class InviteConfirmViewControlelr: UIViewController {
    var alarm: Alarm?

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var vibrationLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBAction func submitButton(_ sender: Any) {
        if let alarm = alarm {
            (AlartFilebase()).updateUserStatus(userId: "mizuki", alarm: alarm, user: JoinedUser(id: "mizuki", name: "mizuki", status: JoinedUserStatus.Joined))
            
            _ = self.navigationController?.popToRootViewController(animated: true)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let alarm = alarm {
            titleLabel.text = alarm.title
            
            if alarm.vibration! {
                vibrationLabel.text = "ON"
            } else {
                vibrationLabel.text = "OFF"
            }
            
            let date = alarm.time
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale!
            dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
            dateLabel.text = dateFormatter.string(from: date!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
