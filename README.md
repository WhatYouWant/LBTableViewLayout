#UITableViewCell图片文本混排



#SDAutoLayout学习分析

获取cell高度的原理
在UITableView+SDAutoTableViewCellHeight分类中，使用SDCellAutoHeightManager来对高度进行管理

```
- (SDCellAutoHeightManager *)cellAutoHeightManager {
 	SDCellAutoHeightManager *cellAutoHeightManager = object_getAssociateObject(self, _cmd);
 	if (!cellAutoHeightManager) {
 		cellAutoHeightManager = [[SDCellAutoHeightManager alloc] init];
 		[[self setCellAutoHeightManager: cellAutoHeightManager]];
 	}
 	return cellAutoHeightManager;
 }
 
 - (void)setCellAutoHeightManager:(SDCellAutoHeightManager *)cellAutoHeightManager{
 		objc_setAssociateObject(self, @selector(cellAutoHeightManager), cellAutoHeightManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
 }
```
通过使用runtime的objc_setAssociateObject，objc_getAssociateObject来为当前的tableView添加关联属性的高度管理器SDCellAutoHeightManager

在cell中的设置model方法中，例如DemoVC14Cell.m中

```
//DemoVC14Cell.m
- (void)setModel:(DemoVC7Model *)model {
	//...设置UI的相关属性
	[self setupAutoHeightWithBottomView:bottomView bottomMargin:10];
}

//UIView+SDAutoHeightWidth
- (void)setupAutoHeightWithBottomView:(UIView *)bottomView bottomMargin:(CGFloat)bottomMargin {
	if(!bottomView) return;
	[self setupAutoHeightWithBottomViewsArray:@[bottomView] bottomMargin:bottomMargin];
}

- (void)setupAutoHeightWithBottomViewsArray:(NSArray *)bottomViewsArray bottomMarigin:(CGFloat)bottomMargin {
	if(!bottomViewsArray) return;
	//清空之前的view
	[self.sd_bottomViewsArray removeAllObjects];
	[self.sd_bottomViewsArray addObjectsFromArray:bottomViewsArray];
	self.sd_bottomViewBottomMargin = bottomMargin;
}
//上面三个方法只有一个目的，那就是确定最底部的view，以及 margin，为后面layoutSubview布局是给autoHeight赋值时做准备。

//DemoVC14.m
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	DemoVC7Model *demoVC14Model = self.modelsArray[indexPath.row];
	return [self.tableView cellHeightForIndexPath:indexPath model:demoVC14Model keyPath:@"model" cellClass:[DemoVC14Cell class] contentViewWidth:[self cellContentViewWidth]];
}

//UITableView+SDAutoTableViewCellHeight
- (CGFloat)cellHeightForIndexPath:(NSIndexPath *)indexPath model:(id)model keyPath:(NSString *)keyPath cellClass:(Class)cellClass contentViewWidth:(CGFloat)contentViewWidth{
    self.cellAutoHeightManager.modelTableview = self;
    self.cellAutoHeightManager.contentViewWidth = contentViewWidth;
    return [self.cellAutoHeightManager cellHeightForIndexPath:indexPath model:model keyPath:keyPath cellClass:cellClass];
}

- (CGFloat)cellHeightForIndexPath:(NSIndexPath *)indexPath model:(id)model keyPath:(NSString *)keyPath
{
	//取已经缓存下的对应的高度，如果有，则直接返回之前计算过的高度
    NSNumber *cacheHeight = [self heightCacheForIndexPath:indexPath];
    if (cacheHeight) {
        return [cacheHeight floatValue];
    } else {
        if (!self.modelCell) {
            return 0;
        }
        
        if (self.modelTableview && self.modelTableview != self.modelCell.sd_tableView) {
            self.modelCell.sd_tableView = self.modelTableview;
        }
        self.modelCell.sd_indexPath = indexPath;
        if (model && keyPath) {
            [self.modelCell setValue:model forKey:keyPath]; //这个地方其实就是调用的setModel方法，在里面会调用上面提到的三个方法
        } else if (self.cellDataSetting) {
            self.cellDataSetting(self.modelCell);
        }
     //...
     		
     		//调用layoutSubviews方法，由于在UIView+SDAutoLayout分类中已经使用runtime交换了两个方法，所以，会在那里面调用自定义的方法，计算出autoHeight
        [self.modelCell.contentView layoutSubviews];
        //对计算出来的autoHeight进行存储，方便下次调用
        NSString *cacheKey = [self cacheKeyForIndexPath:indexPath];
        [_cacheDictionary setObject:@(self.modelCell.autoHeight) forKey:cacheKey];
        
        if (self.modelCell.sd_indexPath && self.modelCell.sd_tableView) {
            if (self.modelCell.contentView.shouldReadjustFrameBeforeStoreCache) {
                self.modelCell.contentView.height_sd = self.modelCell.autoHeight;
                [self.modelCell.contentView layoutSubviews];
            }
            [self.modelCell.contentView.autoLayoutModelsArray enumerateObjectsUsingBlock:^(SDAutoLayoutModel *model, NSUInteger idx, BOOL *stop) {
            //不太明白这个地方，难道是将每个子视图的frame存储起来，下次直接调用？
                [self.modelTableview.cellAutoHeightManager setSubviewFrameCache:model.needsAutoResizeView.frame WithIndexPath:self.modelCell.sd_indexPath];
            }];
        }
        return self.modelCell.autoHeight;
    }
}


```

###使用runtime交换两个方法
####UIView+SDAutoLayout中的load方法
```
+ (void)load {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		
		NSArray *selStringsArray = @[@"layoutSubviews"];
		
		[selStringsArray enumerateObjectsUsingBlock:^(NSString *selString, NSUInteger idx, BOOL *stop) {
			NSString *mySelString = [@"sd_" stringByAppendingString:selString];
			
			Method originalMethod = class_getInstanceMethod(self, NSSelectorFromString(selString));
			Method myMethod = class_getInstanceMethod(self, NSSelectorFromString(mySelString));
			method_exchangeImplementations(originalMethod, myMethod); //交换系统的layoutSubviews方法与自己定义的sd_layoutSubviews方法
		}];
	});
}

- (void)sd_layoutSubviews {
	[self sd_layoutSubviews];  //由于已经交换了，所以，这行代码会去调用系统自带的layoutSubviews方法
	[self sd_layoutSubviewsHandle]; //执行自己定义的layoutSubviews方法
}
```

###UITableView+SDAutoTableViewCellHeight中的load方法
####将tableView中涉及到数据源改变的方法进行自定义交换
```
+(void)load {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSArray *selStringsArray = @[@"reloadData", @"reloadRowsAtIndexPaths:withRowAnimation:",@"deleteRowsAtIndexPaths:withRowAnimation:",@"insertRowsAtIndexPaths:withRowAnimation:"];
		[selStringsArray enumerateObjectsUsingBlock:^(NSString *selString, NSUInteger idx, BOOL *stop) {
			NSString *mySelString = [@"sd_" stringByAppendingString:selString];
			Method originalMethod = class_getInstanceMethod(self, NSSelectorFromString(selString));
			Method myMethod = class_getInstanceMethod(self, NSSelectorFromString(mySelString));
			method_exchangeImplementtations(originalMethod, myMethod); //交换需要交换的方法
		}];
	});
}

- (void)sd_reloadData {
	if(!self.cellAutoHeightManager.shouldKeepHeightCacheWhenReloadingData) {
		[self.cellAutoHeightManager clearHeightCache]; //清除缓存的高度
	}
	[self sd_reloadData]; //调用系统方法reloadData
	self.cellAutoHeightManager.shouldKeepHeightCacheWhenReloadingData = NO;
}

//...自定义其他需要交换的方法

```

**难道是在返回高度方法调用的时候，将对应的约束条件都存储起来，然后在cellForRow调用的时候再直接使用？**

##使用高度估算，会有效提高heightForRowAt函数中的计算速度
```
self.tableView.estimatedRowHeight = 213;
self.tableView.rowHeight = UITableViewAutomaticDimension; //自己调用代理方法计算高度时，不需要添加这一行代码，iOS8中已经默认设置该值。
```
###（iOS10系统））使用高度估算时，对于每一个cell，heightForRowAt这个代理函数，只会执行一次(应该是在估算高度允许的范围之内，只会执行一次)；不使用高度估算时，这个方法会调用4次，如下所述。


###对于tableView的代理方法cellForRowAt与heightForRowAt的调用顺序及次数问题
####在iOS10系统上，对于每一个cell，会先调用三次heightForRowAt方法，再执行cellForRowAt方法，然后，再调用一次heightForRowAt方法，即共执行4次heightForRowAt方法。

###使用instruments的timer工具测试高度计算方法的时间占有率，使用core animation工具计算fps

##测试数据记录
###1个cell：未缓存heightForRow数据 21ms， 缓存数据 22ms
###5个cell：未缓存数据 64ms， 缓存数据 47ms
###10个cell: 未缓存数据 85ms，滑动过程中，数据会不断增加。 缓存数据 56，62，72ms，滑动过程中，基本不改变
*测试过程中发现，计算高度所消耗的时间中，有很大一部分时间花费在```imageView = image```上面，所以可以在计算高度的时候，禁止掉设置image的方法，以此减少计算时间*
####测试数据：计算高度一共消耗36ms，其中，setImage消耗21ms; 使用标志位禁止掉setImage后，只消耗16ms（36-21）
##获取动态高度的方法
###使用SnapKit等自动布局后，布局并不会立即生效，即获取到frame，所以，可以在cell的setModel中，调用以下代码，获取当前cell中最底部控件的frame，来确定最大y值。

```
var model: XXModel? {
	didSet {
		//设置相应UI
		layoutIfNeeded() //->此代码调用之后，会调用系统的layoutSubviews方法，对界面进行布局
		setNeedsLayout()
		//此处获取某个控件frame
	}
}
```

*在使用templateCell计算高度时，由于cell的默认宽度为320，需要设置cell的bounds，否则，会导致计算出现误差。*







理想三旬 - 陈鸿宇
雨后有车驶来 驶过暮色苍白 旧铁皮往南开 恋人已不在 收听浓烟下的 诗歌电台 不动情的咳嗽 至少看起来 归途也还可爱 琴弦少了姿态 再不见那夜里 听歌的小孩 时光匆匆告白 将颠沛磨成卡带 已枯倦的情怀 踏碎成年代 


