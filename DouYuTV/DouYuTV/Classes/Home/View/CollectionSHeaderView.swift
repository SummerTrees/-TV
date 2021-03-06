//
//  CollectionSHeaderView.swift
//  DouYuTV
//
//  Created by mac on 16/9/29.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit


class CollectionSHeaderView: UICollectionReusableView {

    // 1.属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //2.模型属性
    var groupItem : AnchorGroupItem? {
        didSet {
            titleLabel.text = groupItem?.tag_name
            iconImageView.image = UIImage(named: groupItem?.icon_name ?? "home_header_normal")
        
        }
    }
    
    
    
}


// MARK:点击事件
extension CollectionSHeaderView {

    @IBAction func moreBtnClick(_ sender: UIButton) {
        print("点击了更多")
    }



}





