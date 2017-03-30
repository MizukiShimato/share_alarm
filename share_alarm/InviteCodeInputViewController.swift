//
//  InviteCodeInputViewController.swift
//  share_alarm
//
//  Created by suzukiryota on 2017/01/28.
//  Copyright © 2017年 Mizuki Shimato. All rights reserved.
//

import Foundation
import UIKit

class InviteCodeInputViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var inputCodeForm: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        inputCodeForm.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func sendCodeButton(_ sender: Any) {
        if let text = inputCodeForm.text {
            let splitedText = text.components(separatedBy: "@")
            if splitedText.count < 2 {
                return;
            }
            let userId = splitedText[1]
            let alarmId = splitedText[0]
            AlarmService.instance().getOne(id: alarmId, userId: userId) { alarm in
                if alarm == nil {
                    self.appearAlarmDialog(message: "招待コードに該当するアラームがありませんでした", cb: {})
                }
                else {
                    let storyboard: UIStoryboard = self.storyboard!
                    let nextView = storyboard.instantiateViewController(withIdentifier: "InviteConfirm") as! InviteConfirmViewControlelr
                    nextView.alarm = alarm
                    self.navigationController?.pushViewController(nextView, animated: true)
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
