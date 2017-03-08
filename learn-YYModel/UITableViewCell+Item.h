//
//  UITableViewCell+Item.h
//  learn-YYModel
//
//  Created by oahgnehzoul on 2017/3/9.
//  Copyright © 2017年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainFirstPageItem.h"
@interface UITableViewCell (Item)

//- (void)setItem:(MainFirstPageItem *)item;

@property (nonatomic, strong) MainFirstPageItem *item;

@end
