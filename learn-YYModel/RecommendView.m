//
//  RecommendView.m
//  learn-YYModel
//
//  Created by oahgnehzoul on 2017/3/19.
//  Copyright © 2017年 oahgnehzoul. All rights reserved.
//

#import "RecommendView.h"
#import "YYText.h"
#import "NewRecommendView.h"

@interface RecommendView ()

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) NewRecommendView *tagView;
@end
@implementation RecommendView

+ (CGFloat)getHeightWith:(EventDrivenItem *)item {
    if (item.recommendViewHeight > 0) {
        return item.recommendViewHeight;
    }
    __block CGFloat x = 0;
    __block CGFloat y = 20;
    NSString *str = @"个股推荐：";
    CGFloat left = [str getWidthWithFont:14 constrainedToSize:CGSizeMake(200, 1000)];
    __block CGFloat remain = kScreen_Width;
    [item.stocks enumerateObjectsUsingBlock:^(EventDrivenStockItem *stockItem, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat width = [self computeStockItemWidthWith:stockItem];
        if (idx == 0) {
            x = 15 + left;
        }
        if (x + width > remain) {
            x = 15 + left;
            y += 20 + 3;
        }
        x += width;
    }];
    y += 10;
    item.recommendViewHeight = y;
    return y;
}

- (UIButton *)generateButtonWith:(EventDrivenStockItem *)stockItem {
    UIButton *ret = [UIButton buttonWithType:UIButtonTypeCustom];
    ret.titleLabel.font = [UIFont systemFontOfSize:14];
    [ret setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#4b6490"] forState:UIControlStateNormal];
    [ret setTitle:stockItem.stockName forState:UIControlStateNormal];
    ret.size = CGSizeMake([self.class computeStockItemWidthWith:stockItem], 20);
    return ret;
}

- (YYLabel *)generateYYLabelWith:(EventDrivenStockItem *)stockItem {
    YYLabel *label = [YYLabel new];
    label.font = [UIFont systemFontOfSize:14];
    label.displaysAsynchronously = YES;
    label.textColor = [UIColor hx_colorWithHexRGBAString:@"#4b6490"];
    label.text = stockItem.stockName;
    return label;
}

- (UILabel *)generateLabelWith:(EventDrivenStockItem *)stockItem {
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:14];
    label.layer.drawsAsynchronously = YES;
    label.textColor = [UIColor hx_colorWithHexRGBAString:@"#4b6490"];
    label.text = stockItem.stockName;
//    label.size = CGSizeMake([self.class computeStockItemWidthWith:stockItem], 20);
    return label;
}

- (void)tapAction:(UIButton *)button {
    NSLog(@"tapAction");
}

- (void)setItem:(EventDrivenItem *)item {
    _item = item;
    if (!self.leftLabel) {
        NSString *str = @"个股推荐：";
        CGFloat left = [str getWidthWithFont:14 constrainedToSize:CGSizeMake(200, 1000)];
        self.leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, left, 20)];
        self.leftLabel.textColor = [UIColor grayColor];
        self.leftLabel.font = [UIFont systemFontOfSize:14];
        self.leftLabel.text = str;
        [self addSubview:self.leftLabel];
    }
    
//    __block NSMutableArray *strs = @[].mutableCopy;
//    [_item.stocks enumerateObjectsUsingBlock:^(EventDrivenStockItem *stockItem, NSUInteger idx, BOOL * _Nonnull stop) {
//        [strs addObject:stockItem.stockName];
//    }];
    
//    [self.tagView removeFromSuperview];
//    self.tagView = [[NewRecommendView alloc] initWithFrame:CGRectMake(self.leftLabel.right, self.leftLabel.top, kScreen_Width - 15 - self.leftLabel.width , self.item.recommendViewHeight)];
//    self.tagView.dataSource = strs;
//    [self addSubview:self.tagView];
//    [_buttons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
//        [button removeFromSuperview];
//    }];
    [_buttons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    _buttons = @[].mutableCopy;
    [_item.stocks enumerateObjectsUsingBlock:^(EventDrivenStockItem *stockItem, NSUInteger idx, BOOL * _Nonnull stop) {
        YYLabel *label = [self generateYYLabelWith:stockItem];
//        UILabel *label = [self generateLabelWith:stockItem];
        [_buttons addObject:label];
//        [button addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:label];
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSString *str = @"个股推荐：";
    CGFloat left = [str getWidthWithFont:14 constrainedToSize:CGSizeMake(200, 1000)];
    __block CGFloat x = left + 15;
    __block CGFloat y = 0;
    __block CGFloat remain = kScreen_Width;
    [_buttons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        UILabel *label = (UILabel *)obj;
        YYLabel *label = (YYLabel *)obj;
        CGFloat width = [self.class computeStockItemWidthWith:self.item.stocks[idx]];
        if (x + width > remain) {
            x = 15 + left;
            y += 20 + 3;
        }
        label.origin = (CGPoint){x, y};
        label.size = CGSizeMake(width, 20);
        x += label.width;
    }];
}

+ (CGFloat)computeStockItemWidthWith:(EventDrivenStockItem *)item {
    return [item.stockName getWidthWithFont:14 constrainedToSize:CGSizeMake(200, 1000)];
}


@end
