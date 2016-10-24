//
//  NetworoTools.swift
//  DouYuTV
//
//  Created by mac on 16/10/12.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTools {
    class func requestData(_ type : MethodType, urlString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping (_ result : Any) -> ()) {
        
        //1.判断请求方式
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        //2.发送请求和回调
        Alamofire.request(urlString, method: method, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else{
                print(response.result.error)
                return
            }
            
            finishedCallback(result)
        }
        
        
        
    }
    
    
    
    
    
}
