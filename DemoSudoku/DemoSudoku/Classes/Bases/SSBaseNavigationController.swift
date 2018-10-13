//
//  SHBaseNavigationController.swift
//  aitalk
//
//  Created by shj on 2017/11/7.
//  Copyright © 2017年 shj. All rights reserved.
//

import UIKit

class SSBaseNavigationController: UINavigationController, UIGestureRecognizerDelegate {
     override func viewDidLoad() {
        super.viewDidLoad()
//        interactivePopGestureRecognizer?.isEnabled = true
        interactivePopGestureRecognizer?.delegate = self;
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if (viewControllers.count > 1) {
            return true
        }
        return false
    }
}
