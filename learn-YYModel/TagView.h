//
//  TagView.h
//  learn-YYModel
//
//  Created by oahgnehzoul on 2017/5/5.
//  Copyright © 2017年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagView : UIView

- (instancetype)initWithTitles:(NSArray *)titles containWidth:(CGFloat)width;

//- (CGFloat)heightForHome

- (CGFloat)heightForView;

@property (nonatomic, copy) void (^selectTap)(NSString *title);

@end
