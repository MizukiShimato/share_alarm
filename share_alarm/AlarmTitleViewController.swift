//
//  AlarmTitleViewController.swift
//  share_alarm
//
//  Created by suzukiryota on 2017/03/11.
//  Copyright © 2017年 Mizuki Shimato. All rights reserved.
//

import Foundation
import UIKit

class AlarmTitleViewController : UIViewController, AlarmCreateShare, UITextFieldDelegate {
    
    @IBOutlet weak var titleForm: UITextField!
    
    override func viewDidLoad() {
        nextButton.isEnabled = false
        titleForm.delegate = self
    }
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func inputTitle(_ sender: UITextField) {
        if let title = sender.text {
            if title.characters.count > 0 {
                nextButton.isEnabled = true
            } else {
                nextButton.isEnabled = false
            }
            setTitle(title: title)
        }
    }

    @IBAction func onInputTitle(_ sender: UITextField) {
        if let title = sender.text {
            if title.characters.count > 0 {
                nextButton.isEnabled = true
            }
            setTitle(title: title)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        titleForm.resignFirstResponder()
        return true
    }
}
