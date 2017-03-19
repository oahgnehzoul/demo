//
//  ViewController.m
//  learn-YYModel
//
//  Created by oahgnehzoul on 2017/3/4.
//  Copyright © 2017年 oahgnehzoul. All rights reserved.
//

#import "ViewController.h"
#import "EventDrivenItem.h"
#import "EventDrivenTableViewCell.h"
#import "ODRefreshControl.h"
#import "ZDFPSLabel.h"


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<EventDrivenItem *> *dataItems;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger totalPages;
@property (nonatomic, strong) ODRefreshControl *refreshControl;
@property (nonatomic, strong) ZDFPSLabel *fpsLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc] init];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self.tableView registerClass:[EventDrivenTableViewCell class] forCellReuseIdentifier:EventDrivenTableViewCellIdentifier];
        [self.view addSubview:self.tableView];
    }
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    if (!self.fpsLabel) {
        self.fpsLabel = [[ZDFPSLabel alloc] init];
        [self.view addSubview:self.fpsLabel];
        [self.fpsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_top);
        }];
    }
    __weak typeof(self) weakSelf = self;
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf refreshMore];
    }];
    self.currentPage = 1;
    self.dataItems = @[].mutableCopy;
    
    [self refresh];
    
    _refreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
    [_refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
}


- (void)refresh {
    __weak typeof(self) weakSelf = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [manager GET:@"http://app.vip.gaotime.com/gtservice?actionId=listDataAction&order=desc&rows=30&servicehost=20101&sort=UPDATETIME&token=1917c1b23b51c05a74360b6dd7dfdb76" parameters:@{@"page":@(self.currentPage)} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf.refreshControl endRefreshing];
        NSDictionary *dic = responseObject;
        if (dic[@"op_info"][@"total"]) {
            NSInteger count = [dic[@"op_info"][@"total"] integerValue];
            self.totalPages = count / 30 + 1;
            NSArray *array = dic[@"op_info"][@"rows"];
            if (self.currentPage == 1) {
                [self.dataItems removeAllObjects];
            }
            NSArray *ary = [NSArray yy_modelArrayWithClass:[EventDrivenItem class] json:array];
            [self.dataItems addObjectsFromArray:ary];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"cancelled"]) {
            NSLog(@"canceled");
            return;
        }
        NSLog(@"failed");
    }];
//    [task cancel];
//    [manager.session invalidateAndCancel];
}

- (void)refreshMore {
    self.currentPage++;
    [self refresh];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventDrivenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EventDrivenTableViewCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setItem:self.dataItems[indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [EventDrivenTableViewCell getHeightWith:self.dataItems[indexPath.row]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
