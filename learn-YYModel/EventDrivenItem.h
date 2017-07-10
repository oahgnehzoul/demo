//
//  EventDrivenItem.h
//  learn-YYModel
//
//  Created by oahgnehzoul on 2017/3/7.
//  Copyright © 2017年 oahgnehzoul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventDrivenStockItem : NSObject<YYModel>
@property (nonatomic, copy) NSString *stockName;
@property (nonatomic, copy) NSString *stockCode;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;
@end

@interface EventDrivenItem : NSObject<YYModel>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *stockStr;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *eventDrivenId;

@property (nonatomic, strong) NSArray *stocks;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat recommendViewHeight;
@property (nonatomic, copy) NSMutableArray *layouts;

@property (nonatomic, assign) CGFloat titleHeight;
@property (nonatomic, assign) CGFloat subTitleHeight;
@property (nonatomic, assign) CGFloat timeWidth;
@property (nonatomic, assign) CGFloat timeHeight;

@property (nonatomic, assign) CGFloat leftWidth;

@property (nonatomic, copy) NSString *tagStr;
@end
