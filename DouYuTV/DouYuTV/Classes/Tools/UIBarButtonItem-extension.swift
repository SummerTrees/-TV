//
//  UIBarButtonItem-extension.swift
//  DouYuTV
//
//  Created by mac on 16/9/22.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(imageName : String, highImageName : String = "", size : CGSize = CGSize.zero, target : AnyObject? = nil, action : Selector? = nil) {
        let btn = UIButton(type: .Custom)
        btn.setImage(UIImage(named: imageName), forState: UIControlState())
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), forState: .Highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        btn.addTarget(target, action: action!, forControlEvents: .TouchUpInside)
        self.init(customView: btn)
    }
}
