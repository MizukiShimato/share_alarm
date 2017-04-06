//
//  ViewController.swift
//  share_alarm
//
//  Created by Mizuki Shimato on 2016-12-11.
//  Copyright © 2016 Mizuki Shimato. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {
    
    @IBOutlet weak var createAlarmButton: UIButton!
    @IBOutlet weak var listAlarmButton: UIButton!
    @IBOutlet weak var inviteCodeButton: UIButton!
    
    func disableButtons() {
        createAlarmButton.isEnabled = false
        listAlarmButton.isEnabled = false
        inviteCodeButton.isEnabled = false
    }
    
    func enableButtons() {
        createAlarmButton.isEnabled = true
        listAlarmButton.isEnabled = true
        inviteCodeButton.isEnabled = true
    }
    
    static private var firstMount = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        disableButtons()

        if !TopViewController.firstMount {
            loginCheck()
        }

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func loginCheck() {
        // TODO: ログインチェック中は他のページに遷移しないようにする
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        let selector = storyBoard.instantiateViewController(withIdentifier: "MainPage") as! LoginViewController
        
        selector.loginCheck { (logined) in
            TopViewController.firstMount = true
            if !logined {
                self.present(selector, animated: true, completion: {
                    self.enableButtons()
                })
            } else {
                self.enableButtons()
            }
        }
        
//        self.present(selector, animated: true, completion: {
//            self.enableButtons()
//        })
    }
    @IBAction func tapInvitePageJump(_ sender: Any) {
        jumpInvitePage()
    }
    
    @IBAction func tapAlarmCreatePageJump(_ sender: Any) {
        jumpAlarmCreatePage()
    }
    
    
    func jumpInvitePage() {
        let storyBoard = UIStoryboard(name: "InviteInput", bundle: nil)
        let page = storyBoard.instantiateViewController(withIdentifier: "FirstPage") as! InviteCodeInputViewController
        self.navigationController?.pushViewController(page, animated: true)
    }
    
    func jumpAlarmCreatePage() {
        let storyBoard = UIStoryboard(name: "AlarmCreate", bundle: nil)
        let page = storyBoard.instantiateViewController(withIdentifier: "AlarmCreateInputTitle") as! AlarmTitleViewController
        self.navigationController?.pushViewController(page, animated: true)
    }
    
    @IBAction func onLogout(_ sender: Any) {
        onRefresh(sender)
    }
    
    @IBAction func onRefresh(_ sender: Any) {
        let user = UserDefaults.standard
        user.removeObject(forKey: "password")
        user.removeObject(forKey: "user_name")
        loginCheck()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

