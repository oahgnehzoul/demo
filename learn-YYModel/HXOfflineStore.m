//
//  HXOfflineStore.m
//  FMDB-test
//
//  Created by oahgnehzoul on 2017/4/4.
//  Copyright © 2017年 oahgnehzoul. All rights reserved.
//

#import "HXOfflineStore.h"
#import "FMDB.h"


#ifdef DEBUG
#define debugLog(...)    NSLog(__VA_ARGS__)
#define debugMethod()    NSLog(@"%s", __func__)
#define debugError()     NSLog(@"Error at %s Line:%d", __func__, __LINE__)
#else
#define debugLog(...)
#define debugMethod()
#define debugError()
#endif
static NSString *const QUERY_CREATE_TABLE = @"CREATE TABLE IF NOT EXISTS %@ ( \
id TEXT NOT NULL, \
json TEXT NOT NULL, \
createdTime TEXT NOT NULL, \
PRIMARY KEY(id)) \
";
static NSString *const QUERY_SELECT_ALL = @"SELECT * FROM %@";
static NSString *const QUERY_CLEAR_TABLE = @"DELETE from %@";
static NSString *const QUERY_REPLACE_ITEM = @"REPLACE INTO %@ (id, json, createdTime) values (?, ?, ?)";
static NSString *const QUERY_ITEM_SQL = @"SELECT json, createdTime from %@ where id = ? Limit 1";


@interface HXOfflineStore ()

@property (nonatomic, strong) FMDatabaseQueue *queue;

@end

@implementation HXOfflineStore

- (instancetype)initWithDBName:(NSString *)dbName {
    if (self = [super init]) {
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *dbPath = [libraryPath stringByAppendingPathComponent:dbName];
        if (_queue) {
            [self close];
        }
        _queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    }
    return self;
}

- (void)createTable:(NSString *)tableName {
    if (![self.class checkTableName:tableName]) {
        return;
    }
    __block BOOL result;
    [_queue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:[NSString stringWithFormat:QUERY_CREATE_TABLE,tableName]];
    }];
    if (!result) {
        debugLog(@"Failed to create Table:%@",tableName);
    }
}

- (void)clearTable:(NSString *)tableName {
    if (![self.class checkTableName:tableName]) {
        return;
    }
    __block BOOL result;
    [_queue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:[NSString stringWithFormat:QUERY_CLEAR_TABLE,tableName]];
    }];
    if (!result) {
        debugLog(@"Failed to clear table:%@",tableName);
    }
}

- (void)putString:(NSString *)string withId:(NSString *)stringId intoTable:(NSString *)tableName {
    if (!string) {
        debugLog(@"error,string is nil");
        return;
    }
    [self putObject:@[string] withId:stringId intoTable:tableName];
}

- (void)putObject:(id)object withId:(NSString *)objectId intoTable:(NSString *)tableName {
    if (![self.class checkTableName:tableName]) {
        return;
    }
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:0 error:&error];
    if (error) {
        debugLog(@"error,failed to get json data");
        return;
    }
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDate *createDate = [NSDate date];
    NSString *sql = [NSString stringWithFormat:QUERY_REPLACE_ITEM,tableName];
    __block BOOL result;
    [_queue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql,objectId,jsonString,createDate];
    }];
    if (!result) {
        debugLog(@"error,failed to insert/replace into table:%@",tableName);
    }
}

- (id)getObjectById:(NSString *)objectId fromTable:(NSString *)tableName {
    if (![self.class checkTableName:tableName]) {
        return nil;
    }
    __block NSString *json = nil;
    NSString *sql = [NSString stringWithFormat:QUERY_ITEM_SQL, tableName];
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql, objectId];
        if ([rs next]) {
            json = [rs stringForColumn:@"json"];
        }
        [rs close];
    }];
    if (json) {
        NSError *error;
        id result = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (error) {
            debugLog(@"error,failed to parse to json");
            return nil;
        }
        return result;
    }
    return nil;
}

+ (BOOL)checkTableName:(NSString *)tableName {
    if (!tableName || tableName.length == 0 || [tableName rangeOfString:@" "].location != NSNotFound) {
        return NO;
    }
    return YES;
}

- (void)close {
    [_queue close];
    _queue = nil;
}

- (void)dealloc {
    [_queue close];
}

@end
