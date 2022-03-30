//
//  QQBaseVC.h
//  me
//
//  Created by 子不语 on 2021/12/8.
//  Copyright © 2021 gxrb. All rights reserved.
//

#import <UIKit/UIKit.h>

///
#import "QQCommon.h"

NS_ASSUME_NONNULL_BEGIN

// 在声明一个属性的时候加上 __nullable（？可以为空）与__nonnull（！不能为空） 如果放在@property里面的话不用写下划线
typedef void (^QQVCBackBlock)(id __nullable params,id __nullable data);

@interface QQBaseVC : UIViewController

/** 事件等回调*/
@property (nonatomic, copy) QQVCBackBlock qqBlock;

/// 需要列表等刷新的回调
typedef void (^QQRefreshBlock)(id __nullable result,id __nullable error);
@property (nonatomic, copy) QQRefreshBlock refreshBlock;

@end

NS_ASSUME_NONNULL_END
