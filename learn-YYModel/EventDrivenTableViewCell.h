//
//  EventDrivenTableViewCell.h
//  learn-YYModel
//
//  Created by oahgnehzoul on 2017/3/7.
//  Copyright © 2017年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventDrivenItem.h"
#define EventDrivenTableViewCellIdentifier @"EventDrivenTableViewCellIdentifier"
@interface EventDrivenTableViewCell : UITableViewCell

- (void)setItem:(EventDrivenItem *)item;

+ (CGFloat)getHeightWith:(EventDrivenItem *)item;

@end
