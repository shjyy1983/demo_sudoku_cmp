//
//  ViewController.swift
//  DemoContact
//
//  Created by hs on 2018/3/23.
//  Copyright © 2018年 shj. All rights reserved.
//

import UIKit
import SnapKit

class SMenuViewController: SSBaseViewContorller {
    let demos: [[String: String]] = [
        ["name": "九宫格网络图片", "class": "SSFirstViewController"],
        ]
    
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initLayout()
        print(getDocumentsDirectory())
    }
    
    private func initView() {
        title = "Demos"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
    }
    
    private func initLayout() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    func getAPPName() -> String{
        let nameKey = "CFBundleName"
        // 这里也是坑，请不要翻译oc的代码，而是去NSBundle类里面看它的api
        let appName = Bundle.main.object(forInfoDictionaryKey: nameKey) as? String
        return appName!
    }
    
    fileprivate func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

extension SMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let data = demos[indexPath.row]
        cell?.textLabel?.text = "\(data["name"]!)"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = demos[indexPath.row]
        let clsName = data["class"]!
        
        // Swift classes are namespaced based on the module they are compiled in.
        let appName = getAPPName().replacingOccurrences(of: "-", with: "_")
        let clsNameFull = appName + "." + clsName
        let vcType = NSClassFromString(clsNameFull) as! UIViewController.Type
        let vc = vcType.init()
        vc.title = data["name"]
        navigationController?.pushViewController(vc, animated: true)
         
    }
    
}
















