//
//  RXHome.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/3/25.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

import UIKit

class RXHomeViewController: RXBaseViewController {
    //懒加载
    fileprivate lazy var _tableView = UITableView()
    
    //初始化时赋值
//    lazy var tableView = { () -> UITableView in
//        let tempTabView = UITableView()
//        tempTabView.delegate =  self
//        tempTabView.dataSource = self
//        tempTabView.backgroundColor = UIColor.red
//        return tempTabView;
//    }
    
    override func viewDidLoad() {
      super.viewDidLoad()
        
        configUI();
    }
}

// MARK: --configUI--
extension RXHomeViewController{
   fileprivate func configUI()  {
        view.backgroundColor = UIColor.red
    
        _tableView.frame = view.bounds
        _tableView.delegate = self;
        _tableView.dataSource = self;
        view.addSubview(_tableView)
    }
}

// MARK: --请求数据--
extension RXHomeViewController {
   fileprivate func reloadData(){
        
    }
}

// MARK: --tableView delegate--
extension RXHomeViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIndifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIndifier)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellIndifier)
            cell?.selectionStyle = .none
        }
        cell?.textLabel?.text = "测试数据 \(indexPath.row)"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        RXLog("您点击了 \(indexPath.row)")
    }
}


