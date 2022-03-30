//
//  QQBaseTableViewCell.m
//  me
//
//  Created by 子不语 on 2021/12/8.
//  Copyright © 2021 gxrb. All rights reserved.
//

#import "QQBaseTableViewCell.h"

/// 适配
#import "UIView+AdaptScreen.h"

@implementation QQBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    // XIB 适配
    [self adaptScreenWidthWithType:AdaptScreenWidthTypeAll exceptViews:nil];
}

@end
