//
//  InviteInputViewController.swift
//  share_alarm
//
//  Created by suzukiryota on 2017/01/28.
//  Copyright © 2017年 Mizuki Shimato. All rights reserved.
//

import Foundation
import UIKit

class InviteInputViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let storyBoard = UIStoryboard(name: "InviteInput", bundle: nil)
        let page = storyBoard.instantiateViewController(withIdentifier: "FirstPage") as! InviteCodeInputViewController
        self.navigationController?.pushViewController(page, animated: false)
        //self.present(page, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
