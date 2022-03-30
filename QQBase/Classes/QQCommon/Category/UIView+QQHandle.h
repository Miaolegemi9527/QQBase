//
//  UIView+QQHandle.h
//  me
//
//  Created by 子不语 on 2022/1/21.
//  Copyright © 2022 gxrb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (QQHandle)

/** 通过视图(view)获取该视图所在的控制器(viewController)*/
- (nullable UIViewController *)qqFindBelongViewController;

@end

NS_ASSUME_NONNULL_END
