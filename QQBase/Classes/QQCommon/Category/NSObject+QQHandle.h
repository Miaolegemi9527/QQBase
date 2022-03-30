//
//  NSObject+QQHandle.h
//  me
//
//  Created by 子不语 on 2022/1/3.
//  Copyright © 2022 gxrb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (QQHandle)

/** hook 方法*/
+ (BOOL)zbySwizzleMethod:(Class)class orgSel:(SEL)origSel swizzSel:(SEL)altSel;

/** 直接调用父类方法，不重写 */
+ (void)zbyInvokeOriginMethod:(Class)className methodName:(NSString *)methodName Params:(id)params;
- (void)zbyInvokeOriginMethod:(Class)className methodName:(NSString *)methodName Params:(id)params;

@end

NS_ASSUME_NONNULL_END
