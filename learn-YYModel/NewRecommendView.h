//
//  NewRecommendView.h
//  learn-YYModel
//
//  Created by oahgnehzoul on 2017/5/2.
//  Copyright © 2017年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventDrivenItem.h"

@interface NewRecommendView : UIView

@property (nonatomic, copy) void(^tapBlock)(EventDrivenStockItem *stockItem);


@property (nonatomic, strong) EventDrivenItem *item;


@property (nonatomic, strong) NSMutableArray *dataSource;

@end
