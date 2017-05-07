//
//  TextCollectionViewCell.h
//  learn-YYModel
//
//  Created by oahgnehzoul on 2017/5/2.
//  Copyright © 2017年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextCollectionViewCell : UICollectionViewCell

@property (nonatomic,copy) NSString *content;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;


+ (CGSize) getSizeWithContent:(NSString *) content maxWidth:(CGFloat)maxWidth customHeight:(CGFloat)cellHeight;


@end
