//
//  PhotosLayoutCell.swift
//  LBTableViewLayout
//
//  Created by ZhanyaaLi on 2017/8/8.
//  Copyright © 2017年 Hangzhou Zhanya Technology. All rights reserved.
//

import UIKit

class PhotosLayoutCell: UITableViewCell {
    
    lazy var photoContainerView: PhotosContainerView = {
        let containerView: PhotosContainerView = PhotosContainerView(3, verticalSpace: 3, horizonalInset: 5, verticalInset: 5)
        return containerView
    }()
    
    var model: SWModel? {
        didSet{
            
            if templateCell {
                photoContainerView.imagesCount = (model?.images.count)!
            }
            else {
                photoContainerView.imageArray = model?.images
            }
            
            let containerHeight = photoContainerView.totalHeight
            photoContainerView.snp.remakeConstraints { (make) in
                make.left.equalToSuperview();
                make.top.equalToSuperview();
                make.right.equalToSuperview();
                make.height.equalTo(containerHeight)
            }
            cellHeight = containerHeight
            
        }
    }
    
    var cellHeight: CGFloat = 0
    
    
    var templateCell: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .gray
        _addSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func _addSubviews() {
        
        contentView.addSubview(photoContainerView)
        photoContainerView.snp.makeConstraints { (make) in
            make.left.equalToSuperview();
            make.top.equalToSuperview();
            make.right.equalToSuperview();
            make.height.equalTo(0);
        }
        
    }

}
