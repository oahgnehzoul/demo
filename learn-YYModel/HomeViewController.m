//
//  HomeViewController.m
//  learn-YYModel
//
//  Created by oahgnehzoul on 2017/3/9.
//  Copyright © 2017年 oahgnehzoul. All rights reserved.
//

#import "HomeViewController.h"
#import "MainFirstPageItem.h"
#import "JGGTableViewCell.h"
#import "XGRLTableViewCell.h"
#import "SJZXTableViewCell.h"
#import "UITableViewCell+Item.h"
#import "MDTabView.h"
#import "UIView+Additions.h"
@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic, strong) NSMutableDictionary *itemsForSection;

@property (nonatomic, strong) NSMutableArray *dataItems;

@property (nonatomic, strong) NSArray *tabItems;

@property (nonatomic, strong) MDTabView *tabView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc] init];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self.view addSubview:self.tableView];
    }
    //    [self.tableView registerNib:[UINib nibWithNibName:@"JGGTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:JGGTableViewCellIdentifier];
//    [self.tableView registerNib:[UINib nibWithNibName:@"XGRLTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:XGRLTableViewCellIdentifier];
//    [self.tableView registerNib:[UINib nibWithNibName:@"SJZXTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:SJZXTableViewCellIdentifier];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.dataItems = @[].mutableCopy;
    self.itemsForSection = @{}.mutableCopy;
    [self load];
}

- (void)load {
//    __weak typeof(self) weakSelf = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    NSURLSessionDataTask *task = [manager GET:@"http://114.80.55.2:9500/hexinifs/rs/cms/ad/adHomePage?platform=iphone" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *ary = @[].mutableCopy;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = responseObject;
            [self.dataItems addObjectsFromArray:[NSArray yy_modelArrayWithClass:[MainFirstPageItem class] json:dic[@"content"]]];
            [self.dataItems enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSLog(@"%@",obj);
                if ([obj isKindOfClass:[JGGItem class]] || [obj isKindOfClass:[XGRLItem class]] || [obj isKindOfClass:[SJZXItem class]]) {
                    [ary addObject:obj];
                }
            }];
        }
        [self.itemsForSection setObject:ary forKey:@(0)];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
    }];
//    [task cancel];
}

- (Class)cellClassForItem:(MainFirstPageItem *)item AtIndex:(NSIndexPath *)indexPath {
    if ([item isKindOfClass:[JGGItem class]]) {
        return [JGGTableViewCell class];
    }
    if ([item isKindOfClass:[XGRLItem class]]) {
        return [XGRLTableViewCell class];
    }
    if ([item isKindOfClass:[SJZXItem class]]) {
        return [SJZXTableViewCell class];
    }
    return [UITableViewCell class];
}

- (MainFirstPageItem *)itemForCellAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *items = self.itemsForSection[@(indexPath.section)];
    MainFirstPageItem *item = nil;
    if (indexPath.row < items.count) {
        item = items[indexPath.row];
    } else {
        item = [MainFirstPageItem new];
    }
    return item;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainFirstPageItem *item = [self itemForCellAtIndexPath:indexPath];
    Class cellClass = [self cellClassForItem:item AtIndex:indexPath];
    NSString *identifier = NSStringFromClass(cellClass);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (item) {
        cell.item = item;
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.itemsForSection[@(section)];
    NSLog(@"%ld",array.count);
    return [array count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (MDTabView *)tabView {
    if (!_tabView) {
        _tabView = [[MDTabView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width / 1.2, 40)];
        _tabView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _tabView.backgroundColor = [UIColor whiteColor];
        _tabView.delegate = self;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, kScreen_Width, 0.5)];
        line.backgroundColor = [UIColor colorWithWhite:0 alpha:0.06];
        [_tabView addSubview:line];
    }
    return _tabView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1 && self.tabItems) {
        return self.tabView.height;
    }
    
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    
    if (section == 1) {
        view.frame = CGRectMake(0, 0, tableView.width, self.tabView.height);
        view.backgroundColor = [UIColor whiteColor];
        [self.tabView removeFromSuperview];
        if (self.tabItems) {
            self.tabView.items = self.tabItems;
            [view addSubview:self.tabView];
        }
    }
    
    return view;
}

//- (void)tabViewDidSelectedWithItem:(MDTextItem *)item index:(NSInteger)index {

//    [(MDHomeViewController *)self.controller reloadWidthTabId:[NSString stringWithFormat:@"%@", item.params] needPOI:item.has];
//    [self reloadTab:]
//    NSMutableDictionary *trackerContext = [@{@"poid":[NSString stringWithFormat:@"%ld", (long)index+1]} mutableCopy];
//    
//
//}


@end
