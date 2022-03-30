//
//  UIImageView+QQHandle.h
//  me
//
//  Created by 子不语 on 2022/1/16.
//  Copyright © 2022 gxrb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (QQHandle)


/////////////////////////////////////////////////////////////////////////////////
//                         SDWebImage
/////////////////////////////////////////////////////////////////////////////////
/**
 *  设置普通图片加载
 */
- (void)qq_sd_setImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)placeHolderImage;

/**
 *  设置渐现图片加载
 */
- (void)qq_sd_setChangeAlphaImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)placeHolderImage;

/**
 *  设置菊花动画的等待图片
 */
- (void)qq_sd_setIndicatorImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)placeHolderImage;

/**
 *  清除图片缓存
 */
- (void)qq_sd_clearImageCache;

/////////////////////////////////////////////////////////////////////////////////
//                         YYImage
/////////////////////////////////////////////////////////////////////////////////
/**
 *  设置菊花动画的等待图片
 */
- (void)qq_yy_setIndicatorImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)placeHolderImage;


@end

NS_ASSUME_NONNULL_END
