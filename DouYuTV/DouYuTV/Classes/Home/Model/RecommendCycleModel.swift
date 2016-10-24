//
//  RecommendCycleModel.swift
//  DouYuTV
//
//  Created by mac on 16/10/13.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class RecommendCycleModel: NSObject {
    /// 轮播标题
    var title : String = ""
    /// 轮播图片
    var pic_url : String = ""
    /// 轮播对应主播信息
    var anchor : AnchorItem?
    /// 主播信息
    var room : [String : NSObject]? {
        didSet {
            guard let room = room  else { return }
            anchor = AnchorItem(dict: room)
        }
    }

    // MARK:- 自定义构造函数
    init(dict : [String : NSObject]){
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
}
