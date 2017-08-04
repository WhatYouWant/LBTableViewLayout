//
//  LayoutXibCell.swift
//  LBTableViewLayout
//
//  Created by ZhanyaaLi on 2017/8/4.
//  Copyright © 2017年 Hangzhou Zhanya Technology. All rights reserved.
//

import UIKit

class LayoutXibCell: UITableViewCell {
    
    var cellHeight : CGFloat = 130
    
    
    var content: String?{
        didSet {
            print("---didSet content---")
            contentLabel.text = content
        }
    }
    
    var name: String? {
        didSet {
            print("***didSet name***")
            nameLabel.text = name
        }
    }
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("---xibCell awakeFromNib---")
        iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(15);
            make.top.equalTo(15);
            make.width.equalTo(65);
            make.height.equalTo(65);
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(10);
            make.top.equalTo(iconImageView.snp.top);
            make.width.lessThanOrEqualTo(kScreenWidth - 105);
            make.height.equalTo(21);
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.left);
            make.top.equalTo(nameLabel.snp.bottom).offset(5);
            make.width.equalTo(kScreenWidth - 105);
            make.height.greaterThanOrEqualTo(21);
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentLabel.snp.left);
            make.top.equalTo(contentLabel.snp.bottom).offset(5);
            make.width.lessThanOrEqualTo(150);
            make.height.equalTo(16);
        }

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print("---layoutSubviews,contentFrame:\(contentLabel.frame)---")
//        cellHeight = max(iconImageView.frame.origin.y + iconImageView.frame.size.height, contentLabel.frame.origin.y + contentLabel.frame.size.height)
//        print("---LayoutXibCell layoutSubviews&cellHeight:\(cellHeight)---")

    }
    
}
