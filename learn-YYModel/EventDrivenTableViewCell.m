//
//  EventDrivenTableViewCell.m
//  learn-YYModel
//
//  Created by oahgnehzoul on 2017/3/7.
//  Copyright © 2017年 oahgnehzoul. All rights reserved.
//

#import "EventDrivenTableViewCell.h"

@interface EventDrivenTableViewCell ()

@property (nonatomic, strong) EventDrivenItem *item;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UILabel *stockLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation EventDrivenTableViewCell

+ (CGFloat)getHeightWith:(EventDrivenItem *)item {
    CGFloat h = 0;
    h += 15;
    h += [item.title getHeightWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(kScreen_Width - 12 * 2, 1000)];
    h += 5;
    h += [item.subTitle getHeightWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(kScreen_Width, 1000)];
    h += 5;
    NSString *str = [NSString stringWithFormat:@"个股推荐：%@",item.stockTitle];
    h += [str getHeightWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(kScreen_Width - 12 * 2, 1000)];
    h += 15;
    return h;
}

- (void)setItem:(EventDrivenItem *)item {
    _item = item;
    self.titleLabel.text = item.title;
    self.subTitleLabel.text = item.subTitle;
    self.timeLabel.text = item.time;
    self.stockLabel.text = [NSString stringWithFormat:@"个股推荐：%@",item.stockTitle];
    [self setNeedsLayout];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if (!self.titleLabel) {
            self.titleLabel = [UILabel new];
            self.titleLabel.font = [UIFont systemFontOfSize:16];
            self.titleLabel.textColor = [UIColor blackColor];
            self.titleLabel.numberOfLines = 0;
            [self.contentView addSubview:self.titleLabel];
        }
        
        if (!self.subTitleLabel) {
            self.subTitleLabel = [UILabel new];
            self.subTitleLabel.font = [UIFont systemFontOfSize:12];
            self.subTitleLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#4b6490"];
            [self.contentView addSubview:self.subTitleLabel];
        }
        
        if (!self.stockLabel) {
            self.stockLabel = [UILabel new];
            self.stockLabel.font = [UIFont systemFontOfSize:14];
            self.stockLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#4b6490"];
            [self.contentView addSubview:self.stockLabel];
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
    [self.stockLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subTitleLabel);
        make.top.equalTo(self.subTitleLabel.mas_bottom).offset(5);
    }];
}




@end
