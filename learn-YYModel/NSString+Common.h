//
//  NSString+Common.h
//  learn-YYModel
//
//  Created by oahgnehzoul on 2017/3/7.
//  Copyright © 2017年 oahgnehzoul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)
- (CGSize)getSizeWithFont:(CGFloat)font constrainedToSize:(CGSize)size;
- (CGFloat)getHeightWithFont:(CGFloat)font constrainedToSize:(CGSize)size;
- (CGFloat)getWidthWithFont:(CGFloat)font constrainedToSize:(CGSize)size;

@end
