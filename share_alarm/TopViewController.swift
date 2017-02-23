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
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        let selector = storyBoard.instantiateViewController(withIdentifier: "MainPage") as! LoginViewController
        
        selector.loginCheck { (bool) in
            TopViewController.firstMount = true
            if !bool {
                self.present(selector, animated: true, completion: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

