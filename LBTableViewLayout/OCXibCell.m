//
//  OCXibCell.m
//  LBTableViewLayout
//
//  Created by ZhanyaaLi on 2017/8/4.
//  Copyright © 2017年 Hangzhou Zhanya Technology. All rights reserved.
//

#import "OCXibCell.h"
#import "OCXibModel.h"

@interface OCXibCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation OCXibCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(OCXibModel *)model {
    _model = model;
//    [NSThread sleepForTimeInterval:0.05];
    self.userImageView.image = [UIImage imageNamed:model.imageName];
    self.nameLabel.text = model.name;
    self.contentLabel.text = model.content;
}


@end
