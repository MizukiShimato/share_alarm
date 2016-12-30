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
}
