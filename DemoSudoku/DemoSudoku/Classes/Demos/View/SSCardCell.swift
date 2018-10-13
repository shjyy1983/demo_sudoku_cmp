//
//  SSCardCell.swift
//  DemoSudoku
//
//  Created by SHEN on 2018/10/11.
//  Copyright © 2018 shj. All rights reserved.
//

import UIKit

class SSCardCell: UITableViewCell {
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    var sudokuWall: SSSudoKuWall?
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateLayout()
    }
 
    private func initView() {
        sudokuWall = SSSudoKuWall(frame: CGRect(x: 10, y: 10, width: 80, height: 80))
        contentView.addSubview(sudokuWall!)
        contentView.addSubview(nameLabel)
    }
    
    private func updateLayout() {
        nameLabel.frame = CGRect(x: (sudokuWall?.right)! + 10, y: 10, width: 200, height: 20)
    }
    
    func render(_ card: SSCard) {
        sudokuWall?.imageUrlStrings = card.avatars ?? []
        nameLabel.text = card.nickname
    }
}
