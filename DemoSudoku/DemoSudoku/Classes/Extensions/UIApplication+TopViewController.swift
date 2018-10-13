//
//  UIApplication+TopViewController.swift
//  DemoAD
//
//  Created by SHEN on 2018/10/9.
//  Copyright © 2018 shj. All rights reserved.
//

import UIKit

extension UIApplication {
    class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let navigationController = base as? UINavigationController, navigationController.viewControllers.count > 0 {
            return topViewController(navigationController.visibleViewController)
        }
        
        if let tabBarController = base as? UITabBarController {
            if let selected = tabBarController.selectedViewController {
                return topViewController(selected)
            }
        }
        
        if let presentedViewController = base?.presentedViewController {
            return topViewController(presentedViewController)
        }
        
        return base
    }
    
}
