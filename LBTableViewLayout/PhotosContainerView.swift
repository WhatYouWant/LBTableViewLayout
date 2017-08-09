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

    var imageArray : [String]? {  //存储图片名称
        didSet {
            self.addSubImageView()
        }
    }
    
    //用于计算高度
    var imagesCount : Int = 0 {
        didSet {
            let imageRow : Int = imagesCount / perRowNumbers + (imagesCount % perRowNumbers == 0 ? 0 : 1)
            totalHeight = CGFloat(imageRow) * itemWidth + (CGFloat(imageRow) - 1) * verticalSpace + verticalInset * 2
        }
    }
    
    private var imageViewArray : [UIImageView] = []
    
    private var perRowNumbers : Int = 3
    
    private var horizonalSpace : CGFloat = 0
    
    private var verticalSpace : CGFloat = 0
    
    private var horizonalInset : CGFloat = 0
    
    private var verticalInset : CGFloat = 0
    
    private var itemWidth : CGFloat = 0
    
    private var containerWidth: CGFloat = kScreenWidth
    
    var totalHeight : CGFloat = 0

    init(_ horizonalSpace: CGFloat, verticalSpace: CGFloat, horizonalInset: CGFloat, verticalInset: CGFloat) {
        
        super.init(frame: .zero)
        
        self.horizonalSpace = horizonalSpace
        self.verticalSpace = verticalSpace
        self.horizonalInset = horizonalInset
        self.verticalInset = verticalInset
        self.itemWidth = (containerWidth - horizonalInset * 2 - (CGFloat)(perRowNumbers - 1) * horizonalSpace) / CGFloat(perRowNumbers)

        self.backgroundColor = .lightGray

//        layoutIfNeeded()
        //此处会执行layoutSubviews,除了这次之外，还会执行一次
//        setNeedsLayout()
    }
    
    init(_ width: CGFloat, horizonalSpace: CGFloat, verticalSpace: CGFloat, horizonalInset: CGFloat, verticalInset: CGFloat) {
        
        super.init(frame: .zero)
        
        self.containerWidth = width
        self.horizonalSpace = horizonalSpace
        self.verticalSpace = verticalSpace
        self.horizonalInset = horizonalInset
        self.verticalInset = verticalInset
        self.itemWidth = (containerWidth - horizonalInset * 2 - (CGFloat)(perRowNumbers - 1) * horizonalSpace) / CGFloat(perRowNumbers)
        
        self.backgroundColor = .lightGray
        
    }

    
    
    func addSubImageView() {
        
        let needsToAddItemsCount = (imageArray?.count)! - imageViewArray.count
        
        if needsToAddItemsCount > 0 {
            for _ in 0...needsToAddItemsCount {
                let imageView: UIImageView = UIImageView()
                self.addSubview(imageView)
                imageViewArray.append(imageView)
            }
        }
        
        var referencedView : UIView = self
        
        for i in 0..<imageViewArray.count {
            
            let imageView : UIImageView = imageViewArray[i]
            if i < (imageArray?.count)! {
                imageView.isHidden = false
                imageView.image = UIImage.init(named: (imageArray?[i])!)
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
                            make.left.equalTo(referencedView.snp.right).offset(horizonalSpace);
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
            else {
                imageView.snp.removeConstraints()
                imageView.isHidden = true
            }
        }
        
        let imageRow : Int = imageArray!.count / perRowNumbers + (imageArray!.count % perRowNumbers == 0 ? 0 : 1)
        totalHeight = CGFloat(imageRow) * itemWidth + (CGFloat(imageRow) - 1) * verticalSpace + verticalInset * 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("---layoutSubviews---")
    }

}
