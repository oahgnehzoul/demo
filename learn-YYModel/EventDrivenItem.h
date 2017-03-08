//
//  EventDrivenItem.h
//  learn-YYModel
//
//  Created by oahgnehzoul on 2017/3/7.
//  Copyright © 2017年 oahgnehzoul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventDrivenItem : NSObject<YYModel>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *stockTitle;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) NSInteger eventDrivenId;
@end
