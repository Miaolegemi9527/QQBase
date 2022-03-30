//
//  QQBaseCollectionViewCell.m
//  me
//
//  Created by 子不语 on 2021/12/10.
//  Copyright © 2021 gxrb. All rights reserved.
//

#import "QQBaseCollectionViewCell.h"

// 适配
#import "UIView+AdaptScreen.h"

@implementation QQBaseCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // XIB 适配
    [self adaptScreenWidthWithType:AdaptScreenWidthTypeAll exceptViews:nil];
}

@end
