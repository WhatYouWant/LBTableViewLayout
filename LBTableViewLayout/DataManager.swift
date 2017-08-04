//
//  DataManager.swift
//  LBTableViewLayout
//
//  Created by ZhanyaaLi on 2017/8/4.
//  Copyright © 2017年 Hangzhou Zhanya Technology. All rights reserved.
//

import Foundation

class DataManager : NSObject{
    
    var contentArray: [String] = {
        let content1 = "雨后有车驶来 驶过暮色苍白 旧铁皮向南开 恋人已不在 收听浓烟下的诗歌电台 不动情的咳嗽 至少看起来 归途也还可爱 琴弦少了姿态 再不见那夜里 听歌的小孩"
        let content2 = "灯光下的站台，远处迟到的公交，背着包的姑娘，你头也不回的往前走，月亮下的城门，站在路边的姑娘，卖花的小孩，叔叔 买一朵吧" //4行
        let content3 = "也许是年轻 我们还能倔强 还是像个孩子一样 在这路上 有很多感伤 在旅途上 迷失了方向" //3行
        let content4 = "北方的村庄 住着一个南方的姑娘 她总是喜欢穿着带花的裙子 站在路旁" //2行
        let content5 = "把青春献给身后那座 辉煌的都市"  //1行
        
        return [content1, content2, content3, content4, content5]
    }()
    
    var titleArray: [String] = {
        let content1 = "理想三旬-陈鸿宇"
        let content2 = "晚安姑娘-海先生"
        let content3 = "唱歌的孩子-腰乐队"
        let content4 = "南方姑娘-赵雷"
        let content5 = "私奔-郑钧"
        
        return [content1, content2, content3, content4, content5]
    }()
    
    var imageArray: [String] = {
        let image1 = "song1.jpeg"
        let image2 = "song3.jpeg"
        let image3 = "song2.jpeg"
        let image4 = "song5.jpeg"
        let image5 = "song4.jpeg"
        
        return [image1, image2, image3, image4, image5]
    }()
    
    var indexArray: [Int] = {
        var tempArray: [Int] = []
        for i in 0...15 {
            let contentIndex : Int = Int(arc4random_uniform(5))
            tempArray.append(contentIndex)
        }
        return tempArray
    }()


}
