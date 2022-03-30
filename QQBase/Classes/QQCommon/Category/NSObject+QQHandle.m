//
//  NSObject+QQHandle.m
//  me
//
//  Created by 子不语 on 2022/1/3.
//  Copyright © 2022 gxrb. All rights reserved.
//

#import "NSObject+QQHandle.h"

#import <objc/runtime.h>

@implementation NSObject (QQHandle)

/** hook 方法*/
+ (BOOL)zbySwizzleMethod:(Class)class orgSel:(SEL)origSel swizzSel:(SEL)altSel {
    Method origMethod = class_getInstanceMethod(class, origSel);
    Method altMethod = class_getInstanceMethod(class, altSel);
    if (!origMethod || !altMethod) {
        return NO;
    }
    BOOL didAddMethod = class_addMethod(class,origSel,
                                        method_getImplementation(altMethod),
                                        method_getTypeEncoding(altMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,altSel,
                            method_getImplementation(origMethod),
                            method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, altMethod);
    }
    
    return YES;
}

/** 直接调用父类方法，不重写 */
+ (void)zbyInvokeOriginMethod:(Class)className methodName:(NSString *)methodName Params:(id)params {
    u_int count;
    // 此处不要用[self class]，要用[TUIMessageController class]不然获取不到方法名
    // Method *methods = class_copyMethodList([self class], &count);
    Method *methods = class_copyMethodList(className, &count);
    NSInteger index = 0;
    for (int i = 0; i < count; i++) {
        SEL name = method_getName(methods[i]);
        NSString *strName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        if ([strName isEqualToString:methodName]) {
            index = i;  // 先获取原类方法在方法列表中的索引
            // 调用方法
            SEL sel = method_getName(methods[index]);
            IMP imp = method_getImplementation(methods[index]);
            if (params) {
                ((id (*)(id,SEL,id))imp)(self,sel,params);
            } else {
                ((id (*)(id,SEL))imp)(self,sel);
            }
        }
    }
}
- (void)zbyInvokeOriginMethod:(Class)className methodName:(NSString *)methodName Params:(id)params {
    u_int count;
    // 此处不要用[self class]，要用[TUIMessageController class]不然获取不到方法名
    // Method *methods = class_copyMethodList([self class], &count);
    Method *methods = class_copyMethodList(className, &count);
    NSInteger index = 0;
    for (int i = 0; i < count; i++) {
        SEL name = method_getName(methods[i]);
        NSString *strName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        if ([strName isEqualToString:methodName]) {
            index = i;  // 先获取原类方法在方法列表中的索引
            // 调用方法
            SEL sel = method_getName(methods[index]);
            IMP imp = method_getImplementation(methods[index]);
            if (params) {
                ((id (*)(id,SEL,id))imp)(self,sel,params);
            } else {
                ((id (*)(id,SEL))imp)(self,sel);
            }
            return;
        }
    }
}

@end
