//
//  SWModel.swift
//  LBTableViewLayout
//
//  Created by ZhanyaaLi on 2017/8/7.
//  Copyright © 2017年 Hangzhou Zhanya Technology. All rights reserved.
//

import UIKit

class SWModel {
    
    var imageName : String?
    
    var name : String = "标题"
    
    var content : String = "内容"
    
    init(image imageName: String, name: String, content: String) {
        self.imageName = imageName
        self.name = name
        self.content = content
    }
    
    

}
