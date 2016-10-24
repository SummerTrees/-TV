//
//  BaseGroupModel.swift
//  DouYuTV
//
//  Created by mac on 16/10/13.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class BaseGroupModel: NSObject {
    // MARK:属性
    //组名称
    var tag_name : String = ""
    
    //图片地址
    var icon_url : String = ""
    
    
    // MARK:自定义构造函数
    override init() {
        
    }
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
