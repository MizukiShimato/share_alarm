//
//  AlarmDateViewController.swift
//  share_alarm
//
//  Created by suzukiryota on 2017/03/11.
//  Copyright © 2017年 Mizuki Shimato. All rights reserved.
//

import Foundation
import UIKit

class AlarmDateViewController: UIViewController, AlarmCreateShare {
    @IBOutlet weak var datePickr: UIDatePicker!
   
    override func viewDidLoad() {
        datePickr.minimumDate = Date()
    }

    @IBAction func onChangeDatePicker(_ sender: UIDatePicker) {
        setDate(date: sender.date)
    }
}
