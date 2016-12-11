//
//  AlarmCreateViewController.swift
//  share_alarm
//
//  Created by Mizuki Shimato on 2016-12-11.
//  Copyright © 2016 Mizuki Shimato. All rights reserved.
//

import Foundation
import UIKit

class AlarmCreateViewController: UIViewController {
    
    var alarm: Alarm = initialAlarm()
    
    @IBAction func input(_ sender: UITextField) {
                if let text = sender.text {
                    if let duration = Int(text){
                        alarm.duration = duration
        
                    }
        
                }
                dump(alarm)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
