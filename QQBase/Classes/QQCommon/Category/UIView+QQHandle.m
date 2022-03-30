//
//  UIView+QQHandle.m
//  me
//
//  Created by 子不语 on 2022/1/21.
//  Copyright © 2022 gxrb. All rights reserved.
//

#import "UIView+QQHandle.h"

@implementation UIView (QQHandle)

/** 通过视图(view)获取该视图所在的控制器(viewController)*/
- (nullable UIViewController *)qqFindBelongViewController {
    UIResponder *responder = self;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]]) {
            return (UIViewController *)responder;
        }
    return nil;
}

@end
