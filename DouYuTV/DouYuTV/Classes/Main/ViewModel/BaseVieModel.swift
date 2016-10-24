//
//  BaseVieModel.swift
//  DouYuTV
//
//  Created by mac on 16/10/13.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class BaseViewModel: NSObject {
    // MARK:懒加载属性
    lazy var anchorGroups : [AnchorGroupItem] = [AnchorGroupItem]()
    
    
    // MARK:请求
    func loadAnchorData(_ URLString : String, parameters : [String : NSObject]? = nil, finishedCallback : @escaping () -> ()) {
        
        NetworkTools.requestData(.get, urlString: URLString, parameters: parameters) { (result) in
            
            //1.将result转成字典
            guard let resultDict = result as? [String  : NSObject] else{ return }
            //2.根据data该key,获取数组
            guard let anchorArray = resultDict["data"] as? [[String  : NSObject]] else{ return }
            //3.遍历字典转模型
            for dict in anchorArray {
                self.anchorGroups.append(AnchorGroupItem(dict: dict))
            }
            
            finishedCallback()
        }
    }
    
    

}
