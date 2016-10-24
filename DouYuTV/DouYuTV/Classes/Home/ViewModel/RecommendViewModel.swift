//
//  RecommendViewModel.swift
//  DouYuTV
//
//  Created by mac on 16/10/13.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class RecommendViewModel: BaseViewModel {

    // MARK:懒加载属性
    fileprivate lazy var hotDataGroup : AnchorGroupItem = AnchorGroupItem()
    fileprivate lazy var prettyDataGroup : AnchorGroupItem = AnchorGroupItem()
    lazy var cycleModels : [RecommendCycleModel] = [RecommendCycleModel]()
    
    
    func requestData(_ finishCallback : @escaping () -> ()) {
        //0.定义参数
        let parameters = ["limit":"4", "offset" : "0", "time" : Date.getCurrentTime()]
    
        //1.创建请求组
        let dGroup = DispatchGroup()
    
        //2.请求推荐数据
        dGroup.enter()
        NetworkTools.requestData(.get, urlString: kRecommendDataUrl, parameters: ["time" : Date.getCurrentTime() as AnyObject]) { (result) in
            //1.将result转成字典
            guard let resultDict = result as? [String  : NSObject] else{ return }
            //2.根据data该key,获取数组
            guard let anchorArray = resultDict["data"] as? [[String  : NSObject]] else{ return }
            //3.遍历字典转模型
            self.hotDataGroup.tag_name = "热门"
            self.hotDataGroup.icon_name = "home_header_hot"
            
            for dict in anchorArray {
                let anchor : AnchorItem = AnchorItem(dict: dict)
                self.hotDataGroup.anchorArray.append(anchor)
            }
            dGroup.leave()
        }
        
        //3.请求美颜数据
        dGroup.enter()
        NetworkTools.requestData(.get, urlString:kPrettyUrl, parameters: parameters as [String : AnyObject]?) { (result) in
            //1.将result转成字典
            guard let resultDict = result as? [String  : NSObject] else{ return }
            //2.根据data该key,获取数组
            guard let anchorArray = resultDict["data"] as? [[String  : NSObject]] else{ return }
            //3.遍历字典转模型
            self.prettyDataGroup.tag_name = "颜值"
            self.prettyDataGroup.icon_name = "home_header_phone"
            
            for dict in anchorArray {
                let anchor : AnchorItem = AnchorItem(dict: dict)
                self.prettyDataGroup.anchorArray.append(anchor)
            }
            dGroup.leave()
        }
        
        //4.请求2-12游戏数据
        dGroup.enter()
        loadAnchorData(kGameUrl, parameters: parameters as [String : NSObject]?) { 
            dGroup.leave()
        }
        
        dGroup.notify(queue: DispatchQueue.main) { 
            self.anchorGroups.insert(self.prettyDataGroup, at: 0)
            self.anchorGroups.insert(self.hotDataGroup, at: 0)
            finishCallback()
        }
        
        
    }
    
    func requestCycleData(finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, urlString: kCycleUrl, parameters: ["version" : "2.300" as AnyObject]) { (result) in
            //1.转成字典
            guard let resultDict = result as? [String : NSObject] else{ return }
            //2.拿到数组
            guard let resultArray = resultDict["data"] as? [[String : NSObject]] else {return }
            //3.遍历
            for dict in resultArray {
                self.cycleModels.append(RecommendCycleModel(dict: dict))
            }
            
            finishedCallback()
        }
    }
    
}
