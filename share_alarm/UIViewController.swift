//
//  UIViewController.swift
//  movieWatched
//
//  Created by suzukiryota on 2016/11/16.
//  Copyright © 2016年 kiryota. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    func addSubvieWithAutoLayout(_ childView: UIView, parentView: UIView) {
        parentView.addSubview(childView)
        childView.frame.size = parentView.frame.size
    }

    func share(alarmTokenId: String) {
        let activityVC = UIActivityViewController(activityItems: [alarmTokenId], applicationActivities: nil)

        self.present(activityVC, animated: true, completion: nil)
    }

    func createAlarmTokenId(alarmId: String, userId: String) -> String {
        return "\(alarmId)@\(userId)"
    }
    
    func appearAlarmDialog(message: String, cb: @escaping () -> Void) {
        // UIAlertController
        let alertController: UIAlertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        
        // 選択肢
        // 異なる方法でactionを設定してみた
        let actionOK = UIAlertAction(title: "OK", style: .default){
            action in
            cb()
        }

        // actionを追加
        alertController.addAction(actionOK)
        
        // UIAlertの起動
        present(alertController, animated: true, completion: nil)
    }

}
