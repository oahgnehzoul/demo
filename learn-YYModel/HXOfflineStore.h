//
//  HXOfflineStore.h
//  FMDB-test
//
//  Created by oahgnehzoul on 2017/4/4.
//  Copyright © 2017年 oahgnehzoul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXOfflineStore : NSObject

- (instancetype)initWithDBName:(NSString *)dbName;
- (void)createTable:(NSString *)tableName ;
- (void)clearTable:(NSString *)tableName;
- (void)putObject:(id)object withId:(NSString *)objectId intoTable:(NSString *)tableName;
- (id)getObjectById:(NSString *)objectId fromTable:(NSString *)tableName;

@end
