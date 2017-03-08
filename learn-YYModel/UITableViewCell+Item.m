//
//  UITableViewCell+Item.m
//  learn-YYModel
//
//  Created by oahgnehzoul on 2017/3/9.
//  Copyright © 2017年 oahgnehzoul. All rights reserved.
//

#import "UITableViewCell+Item.h"
#import <objc/runtime.h>
@implementation UITableViewCell (Item)

- (void)setItem:(MainFirstPageItem *)item {
    objc_setAssociatedObject(self, @selector(item), item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MainFirstPageItem *)item {
    return objc_getAssociatedObject(self, _cmd);
}



@end
