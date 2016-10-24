
//
//  NSDate-Extension.swift
//  DouYuTV
//
//  Created by mac on 16/10/13.
//  Copyright © 2016年 mac. All rights reserved.
//

import Foundation

extension Date {
    static func getCurrentTime() -> String {
        
        let nowDate = Date()
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    
    }

}
