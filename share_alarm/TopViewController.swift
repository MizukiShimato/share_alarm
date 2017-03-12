//
//  ViewController.swift
//  share_alarm
//
//  Created by Mizuki Shimato on 2016-12-11.
//  Copyright © 2016 Mizuki Shimato. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {
    static private var firstMount = false
    override func viewDidLoad() {
        super.viewDidLoad()

        if !TopViewController.firstMount {
            loginCheck()
        }

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func loginCheck() {
        // TODO: ログインチェック中は他のページに遷移しないようにする
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        let selector = storyBoard.instantiateViewController(withIdentifier: "MainPage") as! LoginViewController
        
        selector.loginCheck { (bool) in
            TopViewController.firstMount = true
            if !bool {
                self.present(selector, animated: true, completion: nil)
            }
        }
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

