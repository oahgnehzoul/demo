//
//  RecommendView.h
//  learn-YYModel
//
//  Created by oahgnehzoul on 2017/3/19.
//  Copyright © 2017年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventDrivenItem.h"

@interface RecommendView : UIView

@property (nonatomic, strong) EventDrivenItem *item;


+ (CGFloat)getHeightWith:(EventDrivenItem *)item;

+ (CGFloat)computeStockItemWidthWith:(EventDrivenStockItem *)item;
@end
