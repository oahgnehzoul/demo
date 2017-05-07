//
//  EventDrivenItem.m
//  learn-YYModel
//
//  Created by oahgnehzoul on 2017/3/7.
//  Copyright © 2017年 oahgnehzoul. All rights reserved.
//

#import "EventDrivenItem.h"

@implementation EventDrivenStockItem



@end

@implementation EventDrivenItem


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{
             @"title":@"REPORTTITLE",
             @"subTitle":@"CONSTDESC",
             @"stockStr":@"TRADINGCODE",
             @"time":@"UPDATETIME",
             @"eventDrivenId":@"ID"
             };
}


- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if (dic[@"TRADINGCODE"]) {
        self.stockStr = dic[@"TRADINGCODE"];
        NSArray *ary = [self.stockStr componentsSeparatedByString:@","];
        NSMutableArray *stocks = @[].mutableCopy;
        [ary enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *sub = [str componentsSeparatedByString:@"|"];
            EventDrivenStockItem *stockItem = [EventDrivenStockItem new];
            stockItem.stockCode = sub[1];
            if (idx != (ary.count - 1)) {
                stockItem.stockName = [NSString stringWithFormat:@"%@、",sub[0]];
            } else {
                stockItem.stockName = sub[0];
            }
            [stocks addObject:stockItem];
        }];
        self.stocks = stocks;
    }
//    NSLog(@"originId:%@",dic[@"ID"]);
//    NSString *value = [NSString stringWithFormat:@"%@",dic[@"ID"]];
//    NSLog(@"intValue:%d",[value intValue]);
//    NSLog(@"integerValue:%ld",[value longValue]);
//    NSLog(@"longlongValue:%lld",[value longLongValue]);

//    EQInt a = [value integerValue];
//    if (__LP64__) {
//        a = [value longValue];
//    }
//    NSLog(@"EQInt:%lld",(long long)a);

//    NSLog(@"%ld",a);
//    NSLog(@"  ");
    return YES;
}
@end
