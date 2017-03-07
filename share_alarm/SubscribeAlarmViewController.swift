//
//  SubscribeAlarmViewController.swift
//  share_alarm
//
//  Created by suzukiryota on 2017/02/14.
//  Copyright © 2017年 Mizuki Shimato. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit

class SubscribeAlarmViewController : UIViewController {
    var alarm: Alarm?
    var subscribeToken: UInt?
    var avPlayer: AVPlayer!
    var avLayer: AVPlayerLayer!

    @IBOutlet weak var wakeupSwitch: UISwitch!
//    @IBOutlet weak var avContainer: UIView!
    
    @IBOutlet weak var avContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        wakeupSwitch.isEnabled = false
        wakeupSwitch.isOn = false
        if let alarm = alarm {
            AlarmService.instance().getOne(id: alarm.id!, userId: alarm.userId!) { subAlarm in
                self.alarm = subAlarm
                if let subAlarm = subAlarm {
                    UIApplication.shared.isIdleTimerDisabled = true
                    self.subscribeToken = AlarmService.instance().subscribe(alarm: subAlarm, cb: self.subscribeAlarm)
                    self.startAlarmTimer(alarm, wokeupDate: alarm.time!)
                }
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.unsubscribeAlarm()
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    func unsubscribeAlarm() {
        if let token = subscribeToken, let alarm = self.alarm {
            AlarmService.instance().unsubscribe(alarm: alarm, handlerId: token)
            self.subscribeToken = nil
        }
    }
    
    func subscribeAlarm(alarm: Alarm?) {
        if let alarm = alarm {
            updateView(alarm: alarm)
        }
    }
    
    func playAlarmMusic() {
        if let alarm = self.alarm, let musicURL = alarm.musicURL, let url = URL(string: musicURL) {
            dump(musicURL)
            
            self.avPlayer = AVPlayer(url: url)
            self.avLayer = AVPlayerLayer(player: self.avPlayer!)
            self.avContainer.layer.addSublayer(self.avLayer!)
            self.avPlayer.play()
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(SubscribeAlarmViewController.musicFin(_:)),
                                                   name: .AVPlayerItemDidPlayToEndTime,
                                                   object: avPlayer?.currentItem)
        }
    }
    
    func musicFin(_ notification: NSNotification) {
        dump("repeat?")
        /**
         * todo: imple
        */
    }
    
    func wokeup() {
        if let alarm = self.alarm {
            AlarmService.instance().changeStateToWokeup(alarm)
        }
    }
    
    func startAlarmTimer(_ alarm: Alarm, wokeupDate: Date) {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            let currentDate = Date()
            self.updateTimerView(time: Int(currentDate.timeIntervalSinceReferenceDate.distance(to: wokeupDate.timeIntervalSinceReferenceDate)))
            if currentDate > wokeupDate {
                self.wakeupSwitch.isEnabled = true
                self.playAlarmMusic()
                timer.invalidate()
            }
        }.fire()
    }
    
    func updateTimerView(time: Int) {
        // todo: 画面表示時計の描画
        dump(time)
    }
    
    func updateView(alarm: Alarm) {
        /**
         * todo: imple
         */
        dump(alarm.joiendUsers) //参加ユーザの状態変更
    }
    func share(message: String) {
        let activityVC = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        
        self.present(activityVC, animated: true, completion: nil)
    }
    
}
