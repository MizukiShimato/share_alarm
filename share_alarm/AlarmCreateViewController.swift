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
    
    @IBAction func musicSelect(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "MusicSelector", bundle: nil)
        let selector = storyBoard.instantiateViewController(withIdentifier: "MainPage") as! MusicSelectorViewController
        selector.setAfterSaveHandler { track in
            self.alarm.musicURL = track.previewUrl
        }
       self.present(selector, animated: true, completion: nil)
    }
    
    @IBAction func input(_ sender: UITextField) {
        if let text = sender.text {
            if let duration = Int(text){
                alarm.duration = duration
            }
        }
        dump(alarm)
    }
    
    @IBAction func titleBox(_ sender: UITextField) {
        if let text2 = sender.text {
            if let title = String(text2){
                alarm.title = title
            }
            dump(alarm)
        }
    }
    
    @IBAction func vibratonSwitch(_ sender: UISwitch) {
        alarm.vibration = sender.isOn
        dump(alarm)
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        alarm.time = sender.date
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
    
    func sendAlarm(_ alarm : Alarm) {
        let instance = AlarmService.instance()
        _ = instance.store(alarm)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        self.sendAlarm(alarm)
        print("come")
        //前の画面に戻る処理を書く
        //selfについてググる
    }

    
}

