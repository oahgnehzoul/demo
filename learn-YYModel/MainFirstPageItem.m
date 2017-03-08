//
//  MainFirstPageItem.m
//  learn-YYModel
//
//  Created by oahgnehzoul on 2017/3/9.
//  Copyright © 2017年 oahgnehzoul. All rights reserved.
//

#import "MainFirstPageItem.h"

@implementation MainFirstPageItem

//+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
//    return @{
//             @"data":[DataUnitItem class]
//             };
//}

//- (NSArray *)datas {
//    if (self.data) {
//        return [NSArray yy_modelArrayWithClass:[DataUnitItem class] json:self.data];
//    }
//    return @[];
//}

+ (Class)modelCustomClassForDictionary:(NSDictionary *)dictionary {
    NSString *str = dictionary[@"tjid"];
    if ([str isEqualToString:@"138"]) {
        return [JGGItem class];
    }
    if ([str isEqualToString:@"139"]) {
        return [XGRLItem class];
    }
    if ([str isEqualToString:@"141"]) {
        return [TZCKItem class];
    }
    if ([str isEqualToString:@"140"]) {
        return [SJZXItem class];
    }
    if ([str isEqualToString:@"152"]) {
        return [GDTItem class];
    }
    return [MainFirstPageItem class];
}

@end


@implementation DataUnitItem



@end

@implementation JGGItem



@end

@implementation GDTItem



@end

@implementation XGRLItem



@end

@implementation TZCKItem



@end

@implementation SJZXItem



@end
