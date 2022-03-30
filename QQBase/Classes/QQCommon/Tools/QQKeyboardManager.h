//
//  QQKeyboardManager.h
//  me
//
//  Created by 子不语 on 2022/1/9.
//  Copyright © 2022 gxrb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QQKeyboardManager : NSObject

/** 解决 转发详情弹窗添加到 keyWindow 上导致 IQKeyboardManager 对 UITextView、UITextField无效的问题，弹出的键盘遮挡  UITextView、UITextField  的问题*/

@end

NS_ASSUME_NONNULL_END
