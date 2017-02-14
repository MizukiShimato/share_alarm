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
    
    @IBOutlet weak var avContainer: UIView! //storyboard紐付け

    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
    func wokeup() {
        if let alarm = self.alarm {
            AlarmService.instance().changeStateToWokeup(alarm)
        }
    }
    
    func startAlarmTimer(_ alarm: Alarm, wokeupDate: Date) {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            let currentDate = Date()
            if currentDate > wokeupDate {
                self.playAlarmMusic()
                timer.invalidate()
            }
        }.fire()
    }
    
    func updateView(alarm: Alarm) {
        dump(alarm.joiendUsers) //参加ユーザの状態変更
    }
    
}
