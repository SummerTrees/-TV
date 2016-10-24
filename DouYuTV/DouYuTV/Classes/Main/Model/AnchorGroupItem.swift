//
//  AnchorGroupItem.swift
//  DouYuTV
//
//  Created by mac on 16/10/13.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class AnchorGroupItem: BaseGroupModel {
    
    //该组中所有的房间
    var room_list : [[String : NSObject]]? {
        didSet {
            guard let room_list = room_list else{ return }
            for dict in room_list {
                anchorArray.append(AnchorItem(dict: dict))
            }
            
        }
    }
    
    //组图标
    var icon_name : String = "home_header_normal"
    
    //定义主播属性数组
    lazy var anchorArray : [AnchorItem] = [AnchorItem]()
}
