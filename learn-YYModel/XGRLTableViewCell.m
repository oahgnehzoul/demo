//
//  XGRLTableViewCell.m
//  learn-YYModel
//
//  Created by oahgnehzoul on 2017/3/9.
//  Copyright © 2017年 oahgnehzoul. All rights reserved.
//

#import "XGRLTableViewCell.h"

@implementation XGRLTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
