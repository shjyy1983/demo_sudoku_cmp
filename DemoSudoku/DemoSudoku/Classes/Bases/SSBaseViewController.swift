//
//  SHJBaseViewController.swift
//  aitalk
//
//  Created by hs on 2018/3/22.
//  Copyright © 2018年 shj. All rights reserved.
//

import UIKit

class SSBaseViewContorller: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 返回按钮常在
        navigationItem.leftItemsSupplementBackButton = true
        
        // 测滑返回
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    } 

    func createButton(title: String, textColor: UIColor, target: Any, selector: Selector) -> UIButton{
        let btn = UIButton(type: .custom)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(textColor, for: .normal)
        btn.setTitleColor(.red, for: .highlighted)
        btn.addTarget(target, action: selector, for: .touchUpInside)
        btn.showsTouchWhenHighlighted = true
        btn.backgroundColor = .lightGray
        return btn
    }

    
    func alert(_ text: String) {
        let alert = UIAlertController(title: "提示", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func asyncAfter(_ sec: CGFloat, _ callack: @escaping () -> Void) {
        let delay = DispatchTimeInterval.microseconds(Int(sec * 1000 * 1000))
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            callack()
        }
    }
    
    func addNavigationBarItem(title: String, target: Any, selector: Selector, isRight: Bool = true) {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.showsTouchWhenHighlighted = true
        button.addTarget(target, action: selector, for: UIControl.Event.touchUpInside)
        let barItem = UIBarButtonItem(customView: button)
        
        if (isRight) {
            if let items = navigationItem.rightBarButtonItems {
                navigationItem.rightBarButtonItems = items + [barItem]
            } else {
                navigationItem.rightBarButtonItems = [barItem]
            }
        } else {
            navigationItem.backBarButtonItem?.title = ""
            if let items = navigationItem.leftBarButtonItems {
                navigationItem.leftBarButtonItems = items + [barItem]
            } else {
                navigationItem.leftBarButtonItems = [barItem]
            }
        }
    }
    
    func addNavigationBarItem(image: UIImage?, target: Any, selector: Selector, isRight: Bool = true) {
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.showsTouchWhenHighlighted = true
        button.addTarget(target, action: selector, for: UIControl.Event.touchUpInside)
        let barItem = UIBarButtonItem(customView: button)
        if (isRight) {
            if let items = navigationItem.rightBarButtonItems {
                navigationItem.rightBarButtonItems = items + [barItem]
            } else {
                navigationItem.rightBarButtonItems = [barItem]
            }
        } else {
            if let items = navigationItem.leftBarButtonItems {
                navigationItem.leftBarButtonItems = items + [barItem]
            } else {
                navigationItem.leftBarButtonItems = [barItem]
            }
        }
    }
    
}
















