//
//  NSBundle+QQResource.m
//  QQBase
//
//  Created by 子不语 on 2022/3/30.
//

#import "NSBundle+QQResource.h"

@implementation NSBundle (QQResource)


+ (NSBundle *)bundleWithBundleName:(nullable NSString *)bundleName podName:(nullable NSString *)podName {
    if (bundleName == nil && podName == nil) {
        @throw @"bundleName和podName不能同时为空";
    } else if (bundleName == nil ) {
        bundleName = podName;
    } else if (podName == nil) {
        podName = bundleName;
    }
    
    if ([bundleName containsString:@".bundle"]) {
        bundleName = [bundleName componentsSeparatedByString:@".bundle"].firstObject;
    }
    //没使用framwork的情况下
    NSURL *associateBundleURL = [[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"];
    //使用framework形式
    if (!associateBundleURL) {
        associateBundleURL = [[NSBundle mainBundle] URLForResource:@"Frameworks" withExtension:nil];
        associateBundleURL = [associateBundleURL URLByAppendingPathComponent:podName];
        associateBundleURL = [associateBundleURL URLByAppendingPathExtension:@"framework"];
        NSBundle *associateBunle = [NSBundle bundleWithURL:associateBundleURL];
        associateBundleURL = [associateBunle URLForResource:bundleName withExtension:@"bundle"];
    }
    
    //生产环境直接返回空
    return associateBundleURL?[NSBundle bundleWithURL:associateBundleURL]:nil;
}


@end
