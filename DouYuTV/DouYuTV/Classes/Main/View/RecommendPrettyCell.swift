//
//  RecommendPrettyCell.swift
//  DouYuTV
//
//  Created by mac on 16/10/12.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class RecommendPrettyCell: RecommendBaseCell {

    @IBOutlet weak var locationBtn: UIButton!
    
    override var anchor: AnchorItem? {
        didSet {
            //1.属性传递
            super.anchor = anchor
            
            //2.设置
            locationBtn.setTitle(anchor?.anchor_city, for: .normal)
        
        }
    
    }
}
