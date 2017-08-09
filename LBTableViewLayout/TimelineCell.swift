//
//  TimelineCell.swift
//  LBTableViewLayout
//
//  Created by ZhanyaaLi on 2017/8/8.
//  Copyright © 2017年 Hangzhou Zhanya Technology. All rights reserved.
//

import UIKit

class TimelineCell: UITableViewCell {
    
    //用户头像
    lazy var userImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .orange
        label.text = "姓名"
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "内容"
        label.backgroundColor = .green
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var photosContainer: PhotosContainerView = {
        let containerView: PhotosContainerView = PhotosContainerView.init(kScreenWidth - 12 - 45 - 20, horizonalSpace: 3, verticalSpace: 3, horizonalInset: 5, verticalInset: 5)
        return containerView
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "刚刚"
        label.backgroundColor = .yellow
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()
    
    var cellHeight: CGFloat = 0
    
    var templateCell: Bool = false
    
    var model: SWModel? {
        didSet {
            userImageView.image = UIImage.init(named: (model?.imageName)!)
            nameLabel.text = model?.name
            contentLabel.text = model?.content
            
            if templateCell {
                photosContainer.imagesCount = (model?.images.count)!
            }
            else {
                photosContainer.imageArray = model?.images
            }
            
            let containerHeight = photosContainer.totalHeight
            photosContainer.snp.remakeConstraints { (make) in
                make.left.equalTo(contentLabel.snp.left);
                make.right.equalTo(-10);
                make.top.equalTo(contentLabel.snp.bottom).offset(10);
                make.height.equalTo(containerHeight);
            }
            
            layoutIfNeeded()
            setNeedsLayout()
            cellHeight = timeLabel.frame.origin.y + timeLabel.frame.size.height
        }
    }
    
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
        
        var cellBounds: CGRect = self.bounds
        cellBounds.size.width = kScreenWidth
        self.bounds = cellBounds
        _addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _addSubviews() {

        contentView.addSubview(userImageView)
        userImageView.snp.makeConstraints { (make) in
            make.left.equalTo(12);
            make.top.equalTo(12);
            make.width.equalTo(45);
            make.height.equalTo(45);
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(userImageView.snp.right).offset(10);
            make.right.equalTo(-10);
            make.top.equalTo(userImageView.snp.top);
            make.height.equalTo(21);
        }
        
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.left);
            make.right.equalTo(-10);
            make.top.equalTo(nameLabel.snp.bottom).offset(10);
            make.height.greaterThanOrEqualTo(0);
        }
        
        
        contentView.addSubview(photosContainer)
        photosContainer.snp.makeConstraints { (make) in
            make.left.equalTo(contentLabel.snp.left);
            make.right.equalTo(-10);
            make.top.equalTo(contentLabel.snp.bottom).offset(10);
            make.height.equalTo(0);
        }
        
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.left);
            make.top.equalTo(photosContainer.snp.bottom).offset(10);
            make.height.equalTo(16);
            make.width.lessThanOrEqualTo(150);
        }
    }
    
    private func _addSubviewsByMethod2() {
        contentView.addSubview(userImageView)
        userImageView.snp.makeConstraints { (make) in
            make.left.equalTo(12);
            make.top.equalTo(12);
            make.width.equalTo(45);
            make.height.equalTo(45);
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(userImageView.snp.right).offset(10);
            make.right.equalTo(-10);
            make.top.equalTo(userImageView.snp.top);
            make.height.equalTo(21);
        }
        /*
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.left);
            make.top.equalTo(nameLabel.snp.bottom).offset(10);
            make.height.equalTo(21);
            make.width.equalTo(100);
        }
        */
        
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.left);
            make.right.equalTo(-10);
            make.top.equalTo(nameLabel.snp.bottom).offset(10);
//            make.bottom.equalToSuperview();
            make.height.greaterThanOrEqualTo(0);
        }
        
        /*
         contentView.addSubview(photosContainer)
         photosContainer.snp.makeConstraints { (make) in
         make.left.equalToSuperview();
         make.right.equalToSuperview();
         make.top.equalTo(contentLabel.snp.bottom).offset(10);
         make.height.equalTo(0);
         }
         */
        
       
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
