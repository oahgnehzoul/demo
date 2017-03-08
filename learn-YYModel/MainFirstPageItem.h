//
//  MainFirstPageItem.h
//  learn-YYModel
//
//  Created by oahgnehzoul on 2017/3/9.
//  Copyright © 2017年 oahgnehzoul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainFirstPageItem : NSObject<YYModel>

@property (nonatomic, copy) NSString *tjid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *titleurl;
@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *op;
@property (nonatomic, copy) NSString *sid;
@property (nonatomic, copy) NSString *iconurl;
@property (nonatomic, copy) NSString *data;
@property (nonatomic, copy) NSArray *datas;
@property (nonatomic, assign) NSInteger position;

@end


@interface DataUnitItem : NSObject<YYModel>

@property (nonatomic, copy) NSString *tjid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *imgurl;
@property (nonatomic, copy) NSString *jumpurl;
@property (nonatomic, copy) NSString *secondtitle;

@end

@interface JGGItem : MainFirstPageItem

@end

@interface GDTItem : MainFirstPageItem

@end

@interface XGRLItem : MainFirstPageItem

@end

@interface TZCKItem : MainFirstPageItem

@end

@interface SJZXItem : MainFirstPageItem

@end
