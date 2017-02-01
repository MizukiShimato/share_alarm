//
//  InviteCodeInputViewController.swift
//  share_alarm
//
//  Created by suzukiryota on 2017/01/28.
//  Copyright © 2017年 Mizuki Shimato. All rights reserved.
//

import Foundation
import UIKit

class InviteCodeInputViewController: UIViewController {
    @IBOutlet weak var inputCodeForm: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func sendCodeButton(_ sender: Any) {
        if let text = inputCodeForm.text {
            let splitedText = text.components(separatedBy: "@")
            let userId = "mizuki"//splitedText[0]
            let alarmId = "-KbuU58Wz5h56WBJer_9"//splitedText[1]
            AlarmService.instance().getOne(id: alarmId, userId: userId) { alarm in
                dump(alarm)
                let storyboard: UIStoryboard = self.storyboard!
                let nextView = storyboard.instantiateViewController(withIdentifier: "InviteConfirm") as! InviteConfirmViewControlelr
                nextView.alarm = alarm
                self.navigationController?.pushViewController(nextView, animated: true)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
