//
//  DispatchTime+extension.swift
//  aitalk_demos
//
//  Created by hs on 2017/11/2.
//  Copyright © 2017年 shj. All rights reserved.
//

import UIKit

extension DispatchTime: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = DispatchTime.now() + .seconds(value)
    }
}

extension DispatchTime: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = DispatchTime.now() + .milliseconds(Int(value * 1000))
    }
}
