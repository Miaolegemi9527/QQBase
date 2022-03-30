//
//  QQCommon.h
//  TopicDesign
//
//  Created by 子不语 on 2022/2/15.
//

#ifndef QQCommon_h
#define QQCommon_h

#import "QQTools.h"
#import "NSBundle+QQResource.h"

/// 弱引用
#define QQWeakSelf __weak typeof(self) weakSelf = self;
/// 颜色
#define QQRGB(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
/// 随机颜色
#define QQRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
/// 十六进制颜色
#define QQHEXColor(hex,a) [UIColor \
colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 \
green:((float)((hex & 0xFF00) >> 8))/255.0 \
blue:((float)(hex & 0xFF))/255.0 alpha:a]
/// 屏幕宽
#define QQScreenW ([UIScreen mainScreen].bounds.size.width)
/// 屏幕高
#define QQScreenH ([UIScreen mainScreen].bounds.size.height)


#endif /* QQCommon_h */
