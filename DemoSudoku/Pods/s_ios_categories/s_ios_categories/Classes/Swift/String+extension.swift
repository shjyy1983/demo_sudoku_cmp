//
//  String+extension.swift
//  aitalk
//
//  Created by hs on 2017/9/26.
//  Copyright © 2017年 shj. All rights reserved.
//

import UIKit

public extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    static func chUnitConvert(_ num: Int) -> String {
        var left = num
        var datas: [Int] = []
        while (left > 0) {
            let part = left % 10000
            left = Int(left / 10000)
            datas.insert(part, at: 0)
        }
        if (datas.count == 1) {
            return String(datas[0])
        }
        else if (datas.count == 2) {
            return String(datas[0]) + "." + String(datas[1] / 100) + "万"
        }
        else if (datas.count == 3) {
            return String(datas[0]) + "." + String(datas[1] / 100) + "亿"
        }
        return String(num)
    }
}

