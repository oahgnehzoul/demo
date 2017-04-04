//
//  EventDrivenTableViewCell.m
//  learn-YYModel
//
//  Created by oahgnehzoul on 2017/3/7.
//  Copyright © 2017年 oahgnehzoul. All rights reserved.
//

#import "EventDrivenTableViewCell.h"
#import "RecommendView.h"
#import "HXOfflineStore.h"

@interface EventDrivenTableViewCell ()

@property (nonatomic, strong) EventDrivenItem *item;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) RecommendView *recommendView;
@property (nonatomic, strong) HXOfflineStore *store;

@end

@implementation EventDrivenTableViewCell

+ (CGFloat)getHeightWith:(EventDrivenItem *)item {
    CGFloat h = 0;
    h += 15;
    h += [item.title getHeightWithFont:16 constrainedToSize:CGSizeMake(kScreen_Width - 12 * 2, 1000)];
    h += 5;
    h += [item.subTitle getHeightWithFont:12 constrainedToSize:CGSizeMake(kScreen_Width, 1000)];
    h += 5;
    CGFloat height = [RecommendView getHeightWith:item];
    h += height;
    item.height = h;
    return h;
}

- (void)setItem:(EventDrivenItem *)item {
    _item = item;
    self.titleLabel.text = item.title;
    self.subTitleLabel.text = item.subTitle;
    self.timeLabel.text = item.time;
    [self.recommendView setItem:item];
    
    self.store = [[HXOfflineStore alloc] initWithDBName:@"EventDriven.db"];
    id result = [self.store getObjectById:item.eventDrivenId fromTable:@"EventDriven_table"];
    if (result) {
        self.titleLabel.textColor = [UIColor redColor];
    } else {
        self.titleLabel.textColor = [UIColor blackColor];
    }
    [self setNeedsLayout];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if (!self.titleLabel) {
            self.titleLabel = [UILabel new];
            self.titleLabel.font = [UIFont systemFontOfSize:16];
            self.titleLabel.textColor = [UIColor blackColor];
            self.titleLabel.numberOfLines = 0;
            
            __weak typeof(self) weakSelf = self;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
                if (weakSelf.goDetailAction) {
                    weakSelf.goDetailAction(weakSelf.item);
                }
            }];
            self.titleLabel.userInteractionEnabled = YES;
            [self.titleLabel addGestureRecognizer:tap];
            [self.contentView addSubview:self.titleLabel];
        }
        
        if (!self.subTitleLabel) {
            self.subTitleLabel = [UILabel new];
            self.subTitleLabel.font = [UIFont systemFontOfSize:12];
            self.subTitleLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#4b6490"];
            [self.contentView addSubview:self.subTitleLabel];
        }
        
        if (!self.recommendView) {
            self.recommendView = [[RecommendView alloc] init];
            [self.contentView addSubview:self.recommendView];
        }
        
        if (!self.timeLabel) {
            self.timeLabel = [UILabel new];
            self.timeLabel.font = [UIFont systemFontOfSize:14];
            self.timeLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#c4c4c4"];
            [self.contentView addSubview:self.timeLabel];

        }
    
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-12);
    }];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-12);
        make.centerY.equalTo(self.subTitleLabel);
    }];
//    CGFloat h = [RecommendView getHeightWith:self.item];
    [self.recommendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.subTitleLabel.mas_bottom).offset(5);
    }];
}




@end
