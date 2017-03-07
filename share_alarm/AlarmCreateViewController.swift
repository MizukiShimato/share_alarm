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
    
    @IBOutlet weak var musicTitleLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBAction func musicSelect(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "MusicSelector", bundle: nil)
        let selector = storyBoard.instantiateViewController(withIdentifier: "MainPage") as! MusicSelectorViewController
        selector.setAfterSaveHandler { track in
            self.alarm.musicURL = track.previewUrl
            self.musicTitleLabel.text = track.trackName
            self.validateAlarm()
        }
       self.present(selector, animated: true, completion: nil)
    }
    
    @IBAction func input(_ sender: UITextField) {
        if let text = sender.text {
            if let duration = Int(text){
                alarm.duration = duration
                validateAlarm()
            }
        }
        dump(alarm)
    }
    
    @IBAction func titleBox(_ sender: UITextField) {
        if let text2 = sender.text {
            if let title = String(text2){
                alarm.title = title
                validateAlarm()
            }
            dump(alarm)
        }
    }
    
    @IBAction func vibratonSwitch(_ sender: UISwitch) {
        alarm.vibration = sender.isOn
        validateAlarm()
        dump(alarm)
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        alarm.time = sender.date
        validateAlarm()
        dump(alarm)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.isEnabled = false
        alarm.userId = Me.instance().id
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sendAlarm(_ alarm : Alarm, cb: @escaping (String) -> Void) {
        let instance = AlarmService.instance()
        instance.store(alarm) { id in
            cb("\(id)@\(Me.instance().id!)")
        }
    }
    
    func validateAlarm() {
        if alarm.validProps() {
            //ボタンの色を変える
            submitButton.isEnabled = true
        } else {
            submitButton.isEnabled = false
        }
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        self.sendAlarm(alarm) { alarmIdToken in
            self.share(alarmTokenId: alarmIdToken)
        }
        //前の画面に戻る処理を書く
        //selfについてググる
    }
    
    func share(alarmTokenId: String) {
        let activityVC = UIActivityViewController(activityItems: [alarmTokenId], applicationActivities: nil)
        
        self.present(activityVC, animated: true, completion: nil)
    }

    
}

