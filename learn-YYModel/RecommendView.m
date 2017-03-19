//
//  RecommendView.m
//  learn-YYModel
//
//  Created by oahgnehzoul on 2017/3/19.
//  Copyright © 2017年 oahgnehzoul. All rights reserved.
//

#import "RecommendView.h"

@interface RecommendView ()

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) UILabel *leftLabel;
@end
@implementation RecommendView

+ (CGFloat)getHeightWith:(EventDrivenItem *)item {
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
    [_buttons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
        [button removeFromSuperview];
    }];
    _buttons = @[].mutableCopy;
    [_item.stocks enumerateObjectsUsingBlock:^(EventDrivenStockItem *stockItem, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [self generateButtonWith:stockItem];
        [_buttons addObject:button];
        [button addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSString *str = @"个股推荐：";
    CGFloat left = [str getWidthWithFont:14 constrainedToSize:CGSizeMake(200, 1000)];
    __block CGFloat x = left + 15;
    __block CGFloat y = 0;
    __block CGFloat remain = kScreen_Width;
    [_buttons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat width = [self.class computeStockItemWidthWith:self.item.stocks[idx]];
        if (x + width > remain) {
            x = 15 + left;
            y += button.height + 3;
        }
        button.origin = (CGPoint){x, y};

        x += button.width;
    }];
}

+ (CGFloat)computeStockItemWidthWith:(EventDrivenStockItem *)item {
    return [item.stockName getWidthWithFont:14 constrainedToSize:CGSizeMake(200, 1000)];
}

@end
