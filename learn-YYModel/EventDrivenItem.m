//
//  EventDrivenItem.m
//  learn-YYModel
//
//  Created by oahgnehzoul on 2017/3/7.
//  Copyright © 2017年 oahgnehzoul. All rights reserved.
//

#import "EventDrivenItem.h"

@implementation EventDrivenItem


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{
             @"title":@"REPORTTITLE",
             @"subTitle":@"CONSTDESC",
             @"stockTitle":@"TRADINGCODE",
             @"time":@"UPDATETIME",
             @"eventDrivenId":@"ID"
             };
}
@end
