//
//  SHJFirstViewController.swift
//  A_Basic_Swift_Project
//
//  Created by hs on 2018/3/23.
//  Copyright © 2018年 shj. All rights reserved.
//

import UIKit
import Kingfisher
import s_ios_categories

class SSFirstViewController: SSBaseViewContorller {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var service = SSService()
    
    var cards: [SSCard] = []
    
    deinit {
        print("SSFirstViewController deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initView()
        initLayout()
    }
    
    private func initData() {
        cards = service.getData()
    }
    
    private func initView() {
        view.addSubview(tableView)
        tableView.register(SSCardCell.self, forCellReuseIdentifier: "Cell")
        addNavigationBarItem(title: "清理cache", target: self, selector: #selector(actionClearCache))
    }
    
    private func initLayout() {
        tableView.frame = view.bounds
    }
    
    @objc func actionClearCache() {
        ImageCache.default.clearMemoryCache()
        ImageCache.default.clearDiskCache()
        alert("完成，返回再次进入查看效果")
    }
    
}

extension SSFirstViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? SSCardCell else {
            return UITableViewCell()
        }
        let card = cards[indexPath.row]
        cell.render(card)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

