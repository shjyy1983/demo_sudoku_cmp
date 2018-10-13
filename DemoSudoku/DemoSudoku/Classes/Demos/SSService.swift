//
//  SSService.swift
//  DemoSudoku
//
//  Created by SHEN on 2018/10/11.
//  Copyright © 2018 shj. All rights reserved.
//

import UIKit

class SSService: NSObject {
    func getData() -> [SSCard] {
        let urlStrings = [
            "https://shjyy1983.github.io/pub_assets/images/avatar_1.jpg",
            "https://shjyy1983.github.io/pub_assets/images/avatar_2.jpg",
            "https://shjyy1983.github.io/pub_assets/images/avatar_3.jpg",
            "https://shjyy1983.github.io/pub_assets/images/avatar_4.jpg",
            "https://shjyy1983.github.io/pub_assets/images/avatar_5.jpg",
            "https://shjyy1983.github.io/pub_assets/images/avatar_6.jpg",
            "https://shjyy1983.github.io/pub_assets/images/avatar_7.jpg",
            "https://shjyy1983.github.io/pub_assets/images/avatar_8.jpg",
            "https://shjyy1983.github.io/pub_assets/images/avatar_9.jpg"
        ]
        
        var cards: [SSCard] = []
        for i in 0..<50 {
            let card = SSCard()
            let n = 1 + i % 9
            card.id = i
            card.nickname = "[\(n)]name_\(i)"
            card.avatars = Array(urlStrings[0..<n])
            cards.append(card)
        }
        return cards
    }
}
