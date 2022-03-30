//
//  UIImageView+QQHandle.m
//  me
//
//  Created by 子不语 on 2022/1/16.
//  Copyright © 2022 gxrb. All rights reserved.
//

#import "UIImageView+QQHandle.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/SDWebImageManager.h>
#import <YYWebImage/UIImageView+YYWebImage.h>
#import "QQCommon.h"

@implementation UIImageView (QQHandle)

/////////////////////////////////////////////////////////////////////////////////
//                         SDWebImage
/////////////////////////////////////////////////////////////////////////////////


/**
 *  设置普通图片加载
 */
- (void)qq_sd_setImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)placeHolderImage {
     [self sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:placeHolderImage options:SDWebImageLowPriority | SDWebImageRetryFailed];
    
}

/**
 *  设置渐现图片加载
 */
- (void)qq_sd_setChangeAlphaImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)placeHolderImage {
    QQWeakSelf
    [self sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:placeHolderImage options:SDWebImageLowPriority | SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        weakSelf.alpha = 0.1;
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (cacheType == SDImageCacheTypeMemory) {
            weakSelf.alpha = 0.5;
            [UIView animateWithDuration:0.5  animations:^{
                weakSelf.alpha = 1.0;
            }];
        }
    }];
}

/**
 *  设置菊花动画的等待图片
 */
- (void)qq_sd_setIndicatorImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)placeHolderImage {
    
    [self removeAllIndicatorView];
    [self addIndicatorView];
    QQWeakSelf
    [self sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:placeHolderImage options:SDWebImageLowPriority | SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [weakSelf removeAllIndicatorView];
        //如果图片未缓存  渐现效果
        if (cacheType == SDImageCacheTypeNone){
            weakSelf.alpha = 0.1;
            [UIView animateWithDuration:0.5  animations:^{
                weakSelf.alpha = 1.0;
            }];
        }
    }];
}

/** 添加转圈圈*/
- (void)addIndicatorView {
    QQWeakSelf
    // 创建指示器：必须放在主线程内才不会报错
    dispatch_async(dispatch_get_main_queue(), ^{
        UIActivityIndicatorView * indicatorPlaceholder = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicatorPlaceholder.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        indicatorPlaceholder.hidesWhenStopped = YES;
        indicatorPlaceholder.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [indicatorPlaceholder startAnimating];
        [weakSelf addSubview:indicatorPlaceholder];
    });
}
/** 消除指示器*/
- (void)removeAllIndicatorView {
    dispatch_async(dispatch_get_main_queue(), ^{
        // 必须放在主线程内才能移除
        for (UIView * view in [self subviews]){
            if ([view isKindOfClass:[UIActivityIndicatorView class]]) {
                [view removeFromSuperview];
            }
        }
    });
}

/**
 *  清除图片缓存
 */
- (void)qq_sd_clearImageCache {
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDWebImageManager sharedManager] cancelAll];
}


/////////////////////////////////////////////////////////////////////////////////
//                         YYImage
/////////////////////////////////////////////////////////////////////////////////

/**
 *  设置菊花动画的等待图片
 */
- (void)qq_yy_setIndicatorImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)placeHolderImage {
    
    [self removeAllIndicatorView];
    [self addIndicatorView];
    QQWeakSelf
    [self yy_setImageWithURL:[NSURL URLWithString:urlString] placeholder:placeHolderImage options:YYWebImageOptionProgressiveBlur completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        [weakSelf removeAllIndicatorView];
    }];
}

@end
