//
//  NewRecommendView.m
//  learn-YYModel
//
//  Created by oahgnehzoul on 2017/5/2.
//  Copyright © 2017年 oahgnehzoul. All rights reserved.
//

#import "NewRecommendView.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "TextCollectionViewCell.h"

@interface NewRecommendView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *tagsView;

@end
@implementation NewRecommendView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.tagsView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.tagsView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    UICollectionViewLeftAlignedLayout *layout = (UICollectionViewLeftAlignedLayout *)_tagsView.collectionViewLayout;
    [layout invalidateLayout];
    _tagsView.frame = self.bounds;
    
}

- (void)setItem:(EventDrivenItem *)item {
    
}

- (void)insertCellAtLast:(NSString *)tag {
    [_dataSource addObject:tag];
    if (_dataSource.count == 1) {
        [_tagsView insertSections:[NSIndexSet indexSetWithIndex:0]];
    } else {
        [_tagsView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:_dataSource.count - 1 inSection:0]]];
    }
    [self invalidateIntrinsicContentSize];
}

- (void)deleteLastCell {
    if (_dataSource.count == 0) {
        return;
    }
    NSIndexPath *lastIndex = [NSIndexPath indexPathForItem:_dataSource.count - 1 inSection:0];
    [_dataSource removeLastObject];
    if (_dataSource.count == 0) {
        [_tagsView deleteSections:[NSIndexSet indexSetWithIndex:lastIndex.section]];
    } else {
        [_tagsView deleteItemsAtIndexPaths:@[lastIndex]];
    }
    [self invalidateIntrinsicContentSize];
}

- (UICollectionView *)tagsView {
    if (!_tagsView) {
        _tagsView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) collectionViewLayout:[[UICollectionViewLeftAlignedLayout alloc] init]];
        _tagsView.dataSource = self;
        [_tagsView registerNib:[UINib nibWithNibName:@"TextCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TextCollectionViewCell"];
    }
    return _tagsView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _dataSource.count == 0 ? 0 : 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TextCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TextCollectionViewCell" forIndexPath:indexPath];
    cell.content = _dataSource[indexPath.row];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [TextCollectionViewCell getSizeWithContent:_dataSource[indexPath.row] maxWidth:_tagsView.frame.size.width customHeight:24];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (self.tapBlock) {
//        self.tapBlock(<#EventDrivenStockItem *stockItem#>)
//    }
}



@end
