//
//  MDTabView.m
//  MeiMeiDa
//
//  Created by Jason Wong on 15/6/16.
//  Copyright (c) 2015年 Jason Wong. All rights reserved.
//

#import "MDTabView.h"

@interface MDTabView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *line;

@end

@implementation MDTabView
@synthesize items = _items;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scrollView];
        _selectedIndex = 0;
        _activeColor = [UIColor colorWithHexString:kMDColorBaseLevel1];
    }
    
    return self;
}

- (void)setItems:(NSArray *)items {
    _items = items;
    
    [self reloadUI];
    [self setSelectedIndex:self.selectedIndex];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    self.scrollView.frame = CGRectMake(0, 0, self.width, self.height);
}

- (void)setActiveColor:(UIColor *)activeColor {
    _activeColor = activeColor;
    self.line.backgroundColor = activeColor;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _scrollView.scrollsToTop = NO;
    }
    
    return _scrollView;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 8, 80, 2)];
        _line.backgroundColor = _activeColor;
    }
    
    return _line;
}

- (void)reloadUI {
    [self.scrollView removeAllSubviews];
    self.buttons = @[].mutableCopy;
    
    //zero divide bug
    if (self.items.count == 0) {
        return;
    }
    
    CGFloat w = self.items.count >= 6 ? 80 : (self.width / self.items.count);
    
    for (int i = 0; i < self.items.count; i++) {
        MDTextItem *item = [self.items objectAtIndex:i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = i;
        button.frame = CGRectMake(i * w, 0, w, self.height);
        button.titleLabel.font = [MDFont fontWithSize:15];
        
        if ([item.params isKindOfClass:[NSDictionary class]] && item.params[@"attributeText"] && [item.params[@"attributeText"] isKindOfClass:[NSAttributedString class]]) {
            NSAttributedString *title = item.params[@"attributeText"];
            [button setAttributedTitle:title forState:UIControlStateNormal];
        } else {
            [button setTitleColor:[UIColor colorWithHexString:kMDColorBaseLevel2] forState:UIControlStateNormal];
            [button setTitle:item.text forState:UIControlStateNormal];
        }
        
        [button addTarget:self action:@selector(doClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
        [self.buttons addObject:button];
    }
    
    self.line.width = w;
    [self.scrollView addSubview:self.line];
    [self.scrollView setContentSize:CGSizeMake(self.items.count * w, self.height)];
}

- (void)doClicked:(UIButton *)button {
    NSInteger oldSelectedIndex = self.selectedIndex;
    self.selectedIndex = button.tag;
    
    if (button.tag != oldSelectedIndex && [self.delegate respondsToSelector:@selector(tabViewDidSelectedWithItem:index:)]) {
        [self.delegate tabViewDidSelectedWithItem:self.items[button.tag] index:button.tag];
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
   
    UIButton *button = [[self.scrollView subviews] firstObject];
    for (UIButton *view in [self.scrollView subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            if ([view titleForState:UIControlStateNormal] && [view titleForState:UIControlStateNormal].length > 0) {
                [view setTitleColor:[UIColor colorWithHexString:view.tag == selectedIndex ? kMDColorBaseLevel2 : kMDColorBaseLevel3] forState:UIControlStateNormal];
            }
            if (view.tag == selectedIndex) {
                button = view;
            }
        }
    }
    
    if (!button || ![button isKindOfClass:[UIButton class]]) {
        return;
    }
    
    NSString *text = button.titleLabel.text;
    CGFloat width = [text sizeWithAttributes:@{NSFontAttributeName: [MDFont fontWithSize:15]}].width;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.line.left = selectedIndex * button.width + (button.width - width) / 2;
        self.line.width = width;
    }];
}

@end
