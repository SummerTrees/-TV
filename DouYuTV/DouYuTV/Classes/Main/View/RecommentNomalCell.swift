//
//  RecommentNomalCell.swift
//  DouYuTV
//
//  Created by mac on 16/9/29.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class RecommentNomalCell: RecommendBaseCell {
    // MARK:- 控件的属性
    @IBOutlet weak var roomNameLabel: UILabel!
    
    // MARK:- 定义模型属性
    override var anchor: AnchorItem? {
        didSet {
            //1.将属性传给父类
            super.anchor = anchor
            
            //2.设置
            roomNameLabel.text = anchor?.room_name
        
        }
    }
    
    
    
}
