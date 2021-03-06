//
//  LayoutCell.swift
//  LBTableViewLayout
//
//  Created by ZhanyaaLi on 2017/8/4.
//  Copyright © 2017年 Hangzhou Zhanya Technology. All rights reserved.
//

import UIKit

class LayoutCell: UITableViewCell {
    
    var cellHeight: CGFloat = 100
    
    //判断是否是template cell
    var templateCell: Bool = false
    
    var model: SWModel? {
        didSet {
            contentLabel.text = model?.content
            nameLabel.text = model?.name
            if !templateCell {
                iconImageView.image = UIImage.init(named: (model?.imageName)!)
            }
            
            print("---before timeLabel.frame:\(timeLabel.frame)---")
            layoutIfNeeded() //此处执行完成之后，会调用系统的layoutSubviews方法
            print("---layoutIfNeeded---")
            setNeedsLayout()
            print("---after timeLabel.frame:\(timeLabel.frame)---")
            cellHeight = timeLabel.frame.origin.y + timeLabel.frame.size.height
            self.prepareForReuse()  //这个地方有没有存在的必要？
        }
    }
    
    private lazy var iconImageView : UIImageView = {
        let imageView : UIImageView = UIImageView()
        imageView.backgroundColor = .orange
        imageView.image = UIImage.init(named: "15.JPG")
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "标题"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.backgroundColor = .green
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "内容"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        label.backgroundColor = .blue
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "2017-08-04"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.backgroundColor = .yellow
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("---awakeFromNib---")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        print("---layoutSubviews timeLabel.frame:\(timeLabel.frame)---")
    }
    
    private func setupSubviews() {
        print("---setupSubviews---")
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(15);
            make.top.equalTo(15);
            make.width.equalTo(65);
            make.height.equalTo(65);
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(10);
            make.top.equalTo(iconImageView.snp.top);
            make.width.lessThanOrEqualTo(kScreenWidth - 105);
            make.height.equalTo(21);
        }
        
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.left);
            make.top.equalTo(nameLabel.snp.bottom).offset(5);
            make.width.equalTo(kScreenWidth - 105);
            make.height.greaterThanOrEqualTo(21);
        }
        
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentLabel.snp.left);
            make.top.equalTo(contentLabel.snp.bottom).offset(5);
            make.width.lessThanOrEqualTo(150);
            make.height.equalTo(16);
        }
    }
}
