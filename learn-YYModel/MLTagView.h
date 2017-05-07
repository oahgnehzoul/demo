//
//  MLTagView.h
//
//  Created by fkm on 2015/12/16.
//  Copyright © 2015年 mokelab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLTagView : UIView

@property(weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

@property CGFloat margin;
@property UIColor *itemTitleColor;
@property CGColorRef itemBorderColor;
@property CGFloat itemCornerRadius;
@property CGFloat itemBorderWidth;
@property CGFloat itemTitlePadding;

- (void)addTag:(NSString*)name;

@end
