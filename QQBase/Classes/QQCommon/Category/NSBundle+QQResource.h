//
//  NSBundle+QQResource.h
//  QQBase
//
//  Created by 子不语 on 2022/3/30.
//

/// 组件里的资源加载

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (QQResource)

/**
 获取文件所在name，默认情况下podName和bundlename相同，传一个即可
 
 @param bundleName bundle名字，就是在resource_bundles里面的名字
 @param podName pod的名字
 @return bundle
 */
+ (NSBundle *)bundleWithBundleName:(nullable NSString *)bundleName podName:(nullable NSString *)podName;

@end

NS_ASSUME_NONNULL_END
