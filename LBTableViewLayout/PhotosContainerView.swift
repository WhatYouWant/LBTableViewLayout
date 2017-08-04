//
//  PhotosContainerView.swift
//  LBTableViewLayout
//
//  Created by ZhanyaaLi on 2017/8/3.
//  Copyright © 2017年 Hangzhou Zhanya Technology. All rights reserved.
//

import UIKit
import SnapKit

let kScreenWidth : CGFloat = UIScreen.main.bounds.size.width
let kScreenHeight : CGFloat = UIScreen.main.bounds.size.height

class PhotosContainerView: UIView {

    var imageArray : [String]? //存储图片名称
    
    var imageViewArray : [UIImageView] = []
    
    var perRowNumbers : Int = 3
    
    var horizonalSpace : CGFloat = 0
    
    var verticalSpace : CGFloat = 0
    
    var horizonalInset : CGFloat = 0
    
    var verticalInset : CGFloat = 0
    
    

    init(_ itemsArray: [String]) {
        
        super.init(frame: .zero)
        
        imageArray = itemsArray
        
        for imageName in imageArray! {
            let imageView : UIImageView = UIImageView.init(image: UIImage.init(named: imageName))
            imageViewArray.append(imageView)
        }
        
        let itemWidth : CGFloat = (kScreenWidth - horizonalInset * 2 - (CGFloat)(perRowNumbers - 1) * horizonalSpace) / CGFloat(perRowNumbers)
        
        var referencedView : UIView = self
        
        for i in 0..<imageViewArray.count {
            let imageView : UIImageView = imageViewArray[i]
            if i < perRowNumbers {
                if i == 0 {
                    imageView.snp.makeConstraints({ (make) in
                        make.left.equalTo(horizonalInset);
                        make.top.equalTo(verticalInset);
                        make.width.equalTo(itemWidth);
                        make.height.equalTo(itemWidth);
                    })
                }
                else {
                    imageView.snp.makeConstraints({ (make) in
                        make.left.equalTo(referencedView).offset(horizonalSpace);
                        make.top.equalTo(referencedView.snp.top);
                        make.width.equalTo(itemWidth);
                        make.height.equalTo(itemWidth);
                    })
                }
                referencedView = imageView
            }
            else {
                referencedView = imageViewArray[i - perRowNumbers]
                imageView.snp.makeConstraints({ (make) in
                    make.left.equalTo(referencedView.snp.left);
                    make.top.equalTo(referencedView.snp.bottom).offset(verticalSpace);
                    make.width.equalTo(itemWidth);
                    make.height.equalTo(itemWidth);
                })
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
