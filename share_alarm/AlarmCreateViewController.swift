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
    
    @IBAction func musicSelect(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "MusicSelector", bundle: nil)
        let selector = storyBoard.instantiateViewController(withIdentifier: "MainPage") as! MusicSelectorViewController
        selector.setAfterSaveHandler { track in
            self.alarm.musicURL = track.previewUrl
        }
        self.present(selector, animated: true, completion: nil)
    }
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
