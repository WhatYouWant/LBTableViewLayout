//
//  PureImagesAutoLayoutController.swift
//  LBTableViewLayout
//
//  Created by ZhanyaaLi on 2017/8/8.
//  Copyright © 2017年 Hangzhou Zhanya Technology. All rights reserved.
//

import UIKit

class PureImagesAutoLayoutController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addCustomImageViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func addCustomImageViews() {
        let imagesArray: [String] = ["0.jpg", "1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg", "6.jpg", "7.jpg"]
        let horizonalSpace: CGFloat = 3
        let verticalSpace: CGFloat = 3
        let horizonalInset: CGFloat = 5
        let verticalInset: CGFloat = 5
        let containerView: PhotosContainerView = PhotosContainerView.init(horizonalSpace, verticalSpace: verticalSpace, horizonalInset: horizonalInset, verticalInset: verticalInset)
        containerView.imageArray = imagesArray
        view.addSubview(containerView)
        
        let containerHeight = containerView.totalHeight
        
        containerView.snp.makeConstraints { (make) in
            make.left.equalToSuperview();
            make.top.equalToSuperview();
            make.right.equalToSuperview();
            make.height.equalTo(containerHeight);
        }
    }

}
