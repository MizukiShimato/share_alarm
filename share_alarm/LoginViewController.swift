//
//  ViewController.swift
//  googlelogin
//
//  Created by suzukiryota on 2016/11/02.
//  Copyright © 2016年 kiryota. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Accounts


import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var passwordForm: UITextField!
    @IBOutlet weak var emailForm: UITextField!
    
    private var username: String!
    
    @IBAction func tapLoginBtn(_ sender: Any) {
        let storage = UserDefaults.standard
        if
            let name = emailForm.text,
            let password = passwordForm.text {
                username = name
                let email = "\(name)@example.com"
                
                storage.set(name, forKey: "user_name")
                storage.set(password, forKey: "password")

                FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: logined)

        }
        

    }
    

    @IBAction func tapSignUp(_ sender: Any) {
        FIRAuth.auth()?.createUser(withEmail: emailForm.text!, password: passwordForm.text!, completion: singUped)
        if
            let name = emailForm.text,
            let password = passwordForm.text {
            username = name
            let email = "\(name)@example.com"
            let storage = UserDefaults.standard

            
            storage.set(name, forKey: "user_name")
            storage.set(password, forKey: "password")
            
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: logined)
            
        }
    }

    func logined(user: FIRUser?, error:Error?) {
        if let error = error {
            print("login user failed! \(error)")
            return
        }
        
        if let user = user {
            exitPage(id: username, name: username)
            print("login user : \(user.email).")
        }
    }
    
    func singUped(user: FIRUser?, error:Error?) {
        if let error = error {
            print("Creating the user failed! \(error)")
            return
        }
        
        if let user = user {
            exitPage(id: username, name: username)
            print("user : \(user.email) has been created successfully.")
        }
    }
    
    func autoLogUser(user: FIRUser?, error:Error?) {
        if let error = error {
            let user = UserDefaults.standard
            user.removeObject(forKey: "password")
            user.removeObject(forKey: "user_name")
            
            print("Creating the user failed! \(error)")
            return
        }
        
        if let user = user {
            exitPage(id: username, name: username)
            print("user : \(user.email) auto login.")
        }
        
    }
    
    func exitPage(id: String, name: String) {
        Me.set(id: username, name: username)
        self.dismiss(animated: true, completion: nil)
    }
    
    func loginCheck(cb: @escaping (_ logined: Bool) -> Void) {
        let user = UserDefaults.standard
        
        user.string(forKey: "user_name")
        user.string(forKey: "password")
        if let userName = user.string(forKey: "user_name"),
            let password = user.string(forKey: "password") {
            username = userName
            FIRAuth.auth()?.signIn(withEmail: "\(userName)@example.com", password: password ) { (user, err) in
                self.autoLogUser(user: user, error: err)
                cb(err == nil)
            }
        } else {
            cb(false)
        }

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
