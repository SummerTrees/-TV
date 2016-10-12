//
//  MainViewController.swift
//  DouYuTV
//
//  Created by mac on 16/9/22.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //添加子控制器
        addChildVcWithSbName("Home")
        addChildVcWithSbName("Live")
        addChildVcWithSbName("Follow")
        addChildVcWithSbName("Profile")
    }
    
}


// MARK:- 添加子控制器
extension MainViewController {

    private func addChildVcWithSbName(name:String) {
        let childVc = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVc)
        
    }

}
