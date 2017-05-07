//
//  MLTagView.m
//
//  Created by fkm on 2015/12/16.
//  Copyright © 2015年 mokelab. All rights reserved.
//

#import "MLTagView.h"

@implementation MLTagView

- (void)addTag:(NSString*)name {
    [self addSubview:[self createTagItemView:name]];
}

- (UIView*)createTagItemView:(NSString*)name {
    UIButton *tagLabel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [tagLabel setTitle:name forState:UIControlStateNormal];
    [tagLabel setTitleColor:self.itemTitleColor forState:UIControlStateDisabled];
    [tagLabel setBackgroundColor:[UIColor whiteColor]];
    [tagLabel.layer setCornerRadius:self.itemCornerRadius];
    [tagLabel.layer setBorderWidth:self.itemBorderWidth];
    [tagLabel.layer setBorderColor:self.itemBorderColor];
    tagLabel.enabled = NO;
    
    // for padding
    CGFloat padding = self.itemBorderWidth + self.itemTitlePadding;
    tagLabel.titleEdgeInsets = UIEdgeInsetsMake(0, padding, 0, padding);
    [tagLabel sizeToFit];
    CGRect frame = tagLabel.frame;
    frame.size.width += padding * 2;
    tagLabel.frame = frame;

    return tagLabel;
}

#pragma mark - UIView events

- (id) initWithCoder:(NSCoder*)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.itemTitleColor = [UIColor blackColor];
        self.itemBorderColor = [UIColor grayColor].CGColor;
        self.itemCornerRadius = 8;
        self.itemBorderWidth = 4;
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    float parentWidth = self.bounds.size.width;
    
    CGFloat marginHalf = self.margin / 2;
    
    float left = 0;
    float top = 0;
    float bottom = 0;
    for (UIView *child in self.subviews) {
        float childWidth = child.frame.size.width;
        float childHeight =child.frame.size.height;
        if (bottom == 0) {
            bottom = childHeight + self.margin;
        }
        if (left + childWidth + self.margin > parentWidth) {
            left = 0;
            top = bottom;
            bottom += childHeight + self.margin;
        }
        CGRect frame = child.frame;
        frame.origin.x = left + marginHalf;
        frame.origin.y = top + marginHalf;
        child.frame = frame;
        
        left += childWidth + self.margin;
    }
    self.heightConstraint.constant = bottom;
}

@end
