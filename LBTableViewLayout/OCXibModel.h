//
//  OCXibModel.h
//  LBTableViewLayout
//
//  Created by ZhanyaaLi on 2017/8/7.
//  Copyright © 2017年 Hangzhou Zhanya Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OCXibModel : NSObject

@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *content;

- (instancetype)initWithImageName:(NSString *)imageName name:(NSString *)name content:(NSString *)content;
- (CGFloat)getStringHeightWithString:(NSString *)string width:(CGFloat)width andFontSize:(CGFloat)fontSize;

@end
