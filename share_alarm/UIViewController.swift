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

    func createAlarmTokenId(alarmId: String, userId: String)-> String {
        return "\(alarmId)@\(userId)"
    }

}
