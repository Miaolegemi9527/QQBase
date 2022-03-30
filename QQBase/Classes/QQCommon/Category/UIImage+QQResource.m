//
//  UIImage+QQResource.m
//  QQBase
//
//  Created by 子不语 on 2022/3/30.
//

#import "UIImage+QQResource.h"

#import "NSBundle+QQResource.h"

@implementation UIImage (QQResource)

+ (UIImage *)imageResourceNamed:(NSString *)name bundleName:(NSString *)bundleName {
    NSBundle *imageBundle = [NSBundle bundleWithBundleName:bundleName podName:nil];
    NSString *imageName = [NSString stringWithFormat:@"%@@%dx", name, (int)[[UIScreen mainScreen] scale]];
    UIImage *image = [[UIImage imageWithContentsOfFile:[imageBundle pathForResource:imageName ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 判断3x图是否存在
    if (!image) {
        imageName = [NSString stringWithFormat:@"%@@2x", name];
        image = [[UIImage imageWithContentsOfFile:[imageBundle pathForResource:imageName ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    // 判断2x图是否存在
    if (!image) {
        image = [[UIImage imageWithContentsOfFile:[imageBundle pathForResource:name ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return image;
}

+ (UIImage *)imageResourceNamed:(NSString *)name {
    return [UIImage imageResourceNamed:name bundleName:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]];
}

+ (UIImage *)imageAssetsNamed:(NSString *)name bundleName:(NSString *)bundleName {
    NSBundle *imageBundle = [NSBundle bundleWithBundleName:bundleName podName:nil];
    UIImage *image = [UIImage imageNamed:name inBundle:imageBundle compatibleWithTraitCollection:nil];
    if (!image) {
        image = [UIImage imageResourceNamed:name bundleName:bundleName];
    }
    if (!image) {
        image = [UIImage imageNamed:name];
    }
    return image;
}

@end
