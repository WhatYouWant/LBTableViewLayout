//
//  OCXibModel.m
//  LBTableViewLayout
//
//  Created by ZhanyaaLi on 2017/8/7.
//  Copyright © 2017年 Hangzhou Zhanya Technology. All rights reserved.
//

#import "OCXibModel.h"

@implementation OCXibModel

- (instancetype)initWithImageName:(NSString *)imageName name:(NSString *)name content:(NSString *)content {
    if (self = [super init]) {
        _imageName = imageName;
        _name = name;
        _content = content;
    }
    return self;
}

- (CGFloat)getStringHeightWithString:(NSString *)string width:(CGFloat)width andFontSize:(CGFloat)fontSize{
    
    if (string.length<=0) {
        return 21;
    }else{
        CGRect rect = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
        CGFloat height = ceilf(rect.size.height);
        return height;
    }
}

@end
