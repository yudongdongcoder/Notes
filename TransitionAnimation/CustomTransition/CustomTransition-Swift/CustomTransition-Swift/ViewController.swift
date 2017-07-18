//
//  ViewController.swift
//  CustomTransition-Swift
//
//  Created by 张星宇 on 16/2/7.
//  Copyright © 2016年 zxy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = true
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        return tableView
    }()
    
    let headetTitleArray = ["Presentation Transitions"]
    let cellTitleArray = ["淡入淡出", "滑动", "自定义Presentation"]
    let cellSubtitleArray = ["一种淡入淡出的动画", "一种交互式切换","使用presentation controller改变被展示的ViewController的布局"]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "自定义页面跳转动画"
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - 实现UITableViewDelegate协议
extension ViewController {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nav: UINavigationController
        switch indexPath.row {
        case 0:
            nav = UINavigationController(rootViewController: CrossDissolveFirstViewController())
        case 1:
            nav = UINavigationController(rootViewController: InteractivityFirstViewController())
        case 2:
            nav = UINavigationController(rootViewController: CustomPresentationFirstViewController())
        default:
            nav = UINavigationController()
            break
        }
        // http://stackoverflow.com/questions/22585416/slow-performance-for-presentviewcontroller-depends-on-complexity-of-presenting
        DispatchQueue.main.async {
            self.present(nav, animated: true, completion: nil)
        }
    }
}

// MARK: - 实现UITableViewDataSource协议
extension ViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return headetTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = UITableViewCell(style: .subtitle, reuseIdentifier: String(describing: UITableViewCell))
        tableViewCell.textLabel?.text = cellTitleArray[indexPath.row]
        tableViewCell.detailTextLabel?.text = cellSubtitleArray[indexPath.row]
        tableViewCell.selectionStyle = .none
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headetTitleArray[section]
    }
}


