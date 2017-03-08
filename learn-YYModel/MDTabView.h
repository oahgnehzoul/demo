//
//  MDTabView.h
//  MeiMeiDa
//
//  Created by Jason Wong on 15/6/16.
//  Copyright (c) 2015年 Jason Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDTextItem.h"

@protocol MDTabViewDelegate <NSObject>

@optional
- (void)tabViewDidSelectedWithItem:(MDTextItem *)item index:(NSInteger)index;

@end

@interface MDTabView : UIView

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) UIColor *activeColor;

@property (nonatomic, weak) id<MDTabViewDelegate> delegate;
@property (nonatomic, assign) NSInteger selectedIndex;

@end