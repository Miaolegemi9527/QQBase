//
//  QQBaseView.m
//  me
//
//  Created by 子不语 on 2021/12/8.
//  Copyright © 2021 gxrb. All rights reserved.
//

#import "QQBaseView.h"

/// 适配
#import "UIView+AdaptScreen.h"
#import "NSBundle+QQResource.h"

@implementation QQBaseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    // XIB 适配
    [self adaptScreenWidthWithType:AdaptScreenWidthTypeAll exceptViews:nil];
}

/** XIB 加载View的方法*/
+ (instancetype)loadFromNib {
    return [[NSBundle bundleWithBundleName:@"QQBase" podName:@""] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

@end
