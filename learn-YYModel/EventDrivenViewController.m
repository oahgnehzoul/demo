//
//  EventDrivenViewController.m
//  learn-YYModel
//
//  Created by oahgnehzoul on 2017/3/19.
//  Copyright © 2017年 oahgnehzoul. All rights reserved.
//

#import "EventDrivenViewController.h"
#import "EventDrivenItem.h"
#import "EventDrivenTableViewCell.h"
#import "ZDFPSLabel.h"
#import "HXOfflineStore.h"
#import "EventDrivenDetailViewController.h"
static NSString *EventDrivenKey = @"http://app.vip.gaotime.com/gtservice?actionId=listDataAction&page=1&rows=30&servicehost=20101&token=1917c1b23b51c05a74360b6dd7dfdb76";
@interface EventDrivenViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataItems;
@property (nonatomic, strong) ZDFPSLabel *fpsLabel;

@property (nonatomic, strong) HXOfflineStore *store;
@end

@implementation EventDrivenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.tableView) {
        self.tableView = [[UITableView alloc] init];
        [self.tableView registerClass:[EventDrivenTableViewCell class] forCellReuseIdentifier:EventDrivenTableViewCellIdentifier];
        [self.view addSubview:self.tableView];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.fpsLabel = [[ZDFPSLabel alloc] init];
    [self.view addSubview:self.fpsLabel];
    [self.fpsLabel sizeToFit];
    self.fpsLabel.alpha = 0;
    [self.fpsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_top);
    }];
    self.fpsLabel.alpha = 1;
    
    [self loadRequest];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)loadRequest {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [manager GET:EventDrivenKey parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        NSArray *rows = dic[@"op_info"][@"rows"];
        self.dataItems = [NSArray modelArrayWithClass:[EventDrivenItem class] json:rows].mutableCopy;
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failed");
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventDrivenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EventDrivenTableViewCellIdentifier forIndexPath:indexPath];
    [cell setItem:self.dataItems[indexPath.row]];
    
    
    __weak typeof(self) weakSelf = self;
    cell.goDetailAction = ^(EventDrivenItem *item){
        NSString *tableName = @"EventDriven_table";
        if (!weakSelf.store) {
            weakSelf.store = [[HXOfflineStore alloc] initWithDBName:@"EventDriven.db"];
            [weakSelf.store createTable:tableName];
        }
        
        [weakSelf.store putObject:@[@(1)] withId:item.eventDrivenId intoTable:tableName];
//        [weakSelf.tableView reloadData];
        [weakSelf.navigationController pushViewController:[[EventDrivenDetailViewController alloc] init] animated:YES];
    };
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventDrivenItem *item = self.dataItems[indexPath.row];
    if (item.height) {
        return item.height;
    }
    return [EventDrivenTableViewCell getHeightWith:self.dataItems[indexPath.row]];
}



@end
