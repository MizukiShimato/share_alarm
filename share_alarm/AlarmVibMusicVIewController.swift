//
//  AlarmVibMusicVIewController.swift
//  share_alarm
//
//  Created by suzukiryota on 2017/03/11.
//  Copyright © 2017年 Mizuki Shimato. All rights reserved.
//

import Foundation
import UIKit

class AlarmVibMusicVIewController : UIViewController, AlarmCreateShare {
    @IBOutlet weak var vib: UILabel!
    @IBOutlet weak var selectedMusicTitleLabel: UILabel!
    @IBAction func onChangeVib(_ sender: UISwitch) {
        self.setVib(vib: sender.isOn)
        vib.text = sender.isOn ? "あり": "なし"
    }
    
    @IBAction func onClickAutoFill(_ sender: Any) {
        setMusicUrl(url: "__omakase__")
        setMusicTitle(title: "おまかせ")
        self.selectedMusicTitleLabel.text = "おまかせ"
    }
    
    func changeSelectedMusicTitle() {
        
    }
    
    @IBOutlet weak var musicTitle: UILabel!
    
    @IBAction func onTapOpenMusicSelector(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "MusicSelector", bundle: nil)
        let selector = storyBoard.instantiateViewController(withIdentifier: "MainPage") as! MusicSelectorViewController
        selector.setAfterSaveHandler { track in
            self.setMusicUrl(url: track.previewUrl)
            self.setMusicTitle(title: track.trackName)
            self.selectedMusicTitleLabel.text = track.trackName
        }
        self.present(selector, animated: true, completion: nil)
    }
 
}
