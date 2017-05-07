//
//  TagView.m
//  learn-YYModel
//
//  Created by oahgnehzoul on 2017/5/5.
//  Copyright © 2017年 oahgnehzoul. All rights reserved.
//

#import "TagView.h"

static const CGFloat fontSize = 14;
static const CGFloat btnPadding = 0;
static const CGFloat btnMarginW = 0;//按钮左右间距
static const CGFloat btnMarginH = 0;//按钮左右间距
static const CGFloat btnHeight = 20;

@interface TagView ()

@property (nonatomic, strong) NSMutableArray *btnAry;


@end

@implementation TagView

- (instancetype)initWithTitles:(NSArray *)titles containWidth:(CGFloat)width {
    if (self = [super init]) {
        _btnAry = @[].mutableCopy;
        NSArray *frames = [self btnFrame:titles containWidth:width];
        int i = 0;
        for (NSArray *arr in frames) {
            UIButton *btn = [self generateBtn:titles[i]];
            btn.frame = CGRectMake([arr[0] floatValue], [arr[1] floatValue], [arr[2] floatValue], [arr[3] floatValue]);
            [self addSubview:btn];
            [_btnAry addObject:btn];
            i++;
        }
    }
    return self;
}

- (NSArray *)btnFrame:(NSArray *)titles containWidth:(CGFloat)width {
    int row = 0;
    CGFloat currentX = 0;
    CGFloat currentY = 0;
    CGFloat preBtnW = 0;
    NSMutableArray *frames = @[].mutableCopy;
    for (int i = 0; i < titles.count; i++) {
        NSString *str = titles[i];
//        CGSize titleSize = [str getWithFont:fontSize constrainedToSize:CGSizeMake(200, 100)];
        CGSize size = [str getSizeWithFont:fontSize constrainedToSize:CGSizeMake(200, 200)];
        CGFloat btnWidth = size.width + btnPadding;
        if (i == 0) {
            currentX = 0;
            preBtnW = btnWidth;
        } else {
            if (preBtnW > width || (currentX + btnWidth + preBtnW) > width) {
                row++;
                currentX = 0;
                preBtnW = btnWidth;
            } else {
                currentX += (btnMarginW + preBtnW);
                preBtnW = btnWidth;
            }
        }
        currentY = row * (btnMarginH + btnHeight);
        NSArray *ary = @[@(currentX),@(currentY),@(btnWidth),@(btnHeight)];
        [frames addObject:ary];
    }
    _btnAry = frames;
    return frames;
}

- (CGFloat)heightForView {
    CGFloat height;
//    if () {
//        <#statements#>
//    }
    return 0;
}

- (UIButton *)generateBtn:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return btn;
}

- (void)clicked:(UIButton *)sender {
    if (self.selectTap) {
        self.selectTap(sender.currentTitle);
    }
}

@end
