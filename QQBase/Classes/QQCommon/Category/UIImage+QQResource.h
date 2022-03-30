//
//  UIImage+QQResource.h
//  QQBase
//
//  Created by 子不语 on 2022/3/30.
//

/// 组件里的图片资源加载

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (QQResource)

+ (UIImage *)imageResourceNamed:(NSString *)name;

+ (UIImage *)imageResourceNamed:(NSString *)name bundleName:(NSString *)bundleName;

+ (UIImage *)imageAssetsNamed:(NSString *)name bundleName:(NSString *)bundleName;

@end

NS_ASSUME_NONNULL_END
