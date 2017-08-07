//
//  OCXibAutoLayoutController.m
//  LBTableViewLayout
//
//  Created by ZhanyaaLi on 2017/8/4.
//  Copyright © 2017年 Hangzhou Zhanya Technology. All rights reserved.
//

#import "OCXibAutoLayoutController.h"
#import "OCXibCell.h"
#import "OCXibModel.h"

#define kCellIdentifier @"OCXibCell"

@interface OCXibAutoLayoutController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) OCXibCell *templateCell;
@property (nonatomic, strong) NSArray<NSString *> *contentArray, *titleArray, *imageArray;
@property (nonatomic, strong) NSMutableArray<OCXibModel *> *modelArray;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *cellHeightArray;

@end

@implementation OCXibAutoLayoutController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configAllParams];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configAllParams {
    self.contentArray = @[@"雨后有车驶来 驶过暮色苍白 旧铁皮向南开 恋人已不在 收听浓烟下的诗歌电台 不动情的咳嗽 至少看起来 归途也还可爱 琴弦少了姿态 再不见那夜里 听歌的小孩", @"灯光下的站台，远处迟到的公交，背着包的姑娘，你头也不回的往前走，月亮下的城门，站在路边的姑娘，卖花的小孩，叔叔 买一朵吧", @"也许是年轻 我们还能倔强 还是像个孩子一样 在这路上 有很多感伤 在旅途上 迷失了方向", @"北方的村庄 住着一个南方的姑娘 她总是喜欢穿着带花的裙子 站在路旁", @"把青春献给身后那座 辉煌的都市"];
    
    self.titleArray = @[@"理想三旬-陈鸿宇", @"晚安姑娘-海先生", @"唱歌的孩子-腰乐队", @"南方姑娘-赵雷", @"私奔-郑钧"];
    
    self.imageArray = @[@"song1.jpeg", @"song3.jpeg", @"song2.jpeg", @"song5.jpeg", @"song4.jpeg"];
    
    self.modelArray = [NSMutableArray array];
    for (int i = 0; i < 15; i++) {
        int index = arc4random_uniform(5);
        OCXibModel *model = [[OCXibModel alloc] initWithImageName:_imageArray[index] name:_titleArray[index] content:_contentArray[index]];
        [self.modelArray addObject:model];
    }
    self.cellHeightArray = [NSMutableArray array];
}

- (CGFloat)lb_systemFittingHeightForTemplateCell:(UITableViewCell *)cell {
    
    CGFloat contentViewWidth = CGRectGetWidth(self.tableView.frame);
    
    CGRect cellBounds = cell.bounds;
    cellBounds.size.width = contentViewWidth;
    cell.bounds = cellBounds;
    
    CGFloat fittingHeight = 0;
    if (contentViewWidth > 0) {
        NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:contentViewWidth];
        
        static BOOL isSystemVersionEqualOrGreaterThan10_2 = NO;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            isSystemVersionEqualOrGreaterThan10_2 = [UIDevice.currentDevice.systemVersion compare:@"10.2" options:NSNumericSearch] != NSOrderedAscending;
        });
        
        NSArray<NSLayoutConstraint *> *edgeConstraints;
        if (isSystemVersionEqualOrGreaterThan10_2) {
            widthFenceConstraint.priority = UILayoutPriorityRequired - 1;
            
            //Build edge constraints
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
            NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
            NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
            edgeConstraints = @[leftConstraint, rightConstraint, topConstraint, bottomConstraint];
            [cell addConstraints:edgeConstraints];
        }
        
        [cell.contentView addConstraint:widthFenceConstraint];
        
        //Auto layout engine does its math
        fittingHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        
        //Clean-ups
        [cell.contentView removeConstraint:widthFenceConstraint];
        if (isSystemVersionEqualOrGreaterThan10_2) {
            [cell removeConstraints:edgeConstraints];
        }
    }
    
    if (fittingHeight == 0) {
        //此处没有处理
        fittingHeight = [cell sizeThatFits:CGSizeMake(contentViewWidth, 0)].height;
        
        NSLog(@"---calculate using sizeThatFits-%@", @(fittingHeight));
    }
    
    if (fittingHeight == 0) {
        fittingHeight = 44;
    }
    
    if (self.tableView.separatorStyle != UITableViewCellSeparatorStyleNone) {
        fittingHeight += 1.0;
    }
//    NSLog(@"***fittingHeight:%@---", @(fittingHeight));
    
    return fittingHeight;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OCXibCell *cell = (OCXibCell *)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (nil == cell) {
        cell = (OCXibCell *)[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([OCXibCell class]) owner:nil options:nil].lastObject;
    }
    cell.model = _modelArray[indexPath.row];
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

#pragma mark -- 第一种计算方法使用FDTemplate中的计算方法 未开启估算: 110ms, 28%, 开启估算: 17ms， 5.1%
/*
    if (indexPath.row < _cellHeightArray.count) {
        return _cellHeightArray[indexPath.row].floatValue;
    }
    
    self.templateCell.model = _modelArray[indexPath.row];
    CGFloat cellHeight = [self lb_systemFittingHeightForTemplateCell:self.templateCell];
    [self.cellHeightArray addObject:@(cellHeight)];
    return cellHeight;
    */
    
#pragma mark -- 使用系统自带的手动计算方法 未开启估算:18ms, 5.4%;   开启估算: 6ms， 1.7%
    /*
    OCXibModel *model = _modelArray[indexPath.row];
    return  [model getStringHeightWithString:model.content width:self.view.bounds.size.width - 92 andFontSize:15] + 57;
    */
//}


#pragma mark - Getter && Setter
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([OCXibCell class]) bundle:nil];
        [_tableView registerNib:cellNib forCellReuseIdentifier:kCellIdentifier];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 100;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        self.templateCell = [_tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    }
    return _tableView;
}

@end
