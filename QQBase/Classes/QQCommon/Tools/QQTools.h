//
//  QQTools.h
//  me
//
//  Created by 子不语 on 2022/1/13.
//  Copyright © 2022 gxrb. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QQTools : NSObject

/** MD5 加密或者将特殊字符转(如群ID)成可以正常当做表名的字符串*/
+ (NSString *)stringToMd5:(NSString *)str;

/** 时间戳转字符串 formatter传nil则默认为 yyyy-MM-dd hh:mm:ss 格式*/
+ (NSString *)timestampToString:(NSInteger)timestamp formatter:(NSString * __nullable)formatter;

/** 时间戳转时间*/
+ (NSDate *)timestampToDate:(NSInteger)timestamp formatter:(NSString * __nullable)formatter;

/** 时间转时间戳*/
+ (NSString *)dateToTimestamp:(NSDate *)date;

/** 字符串转时间*/
+ (NSDate *)stringToDate:(NSString *)dateStr formatter:(NSString * __nullable)formatter;

/** 字符串转时间，转换不会有时差的问题*/
+ (NSDate *)stringToUTCDate:(NSString *)dateStr formatter:(NSString * __nullable)formatter;

/** 字符串转时间戳*/
+ (NSInteger)stringToTimestamp:(NSString *)dateStr formatter:(NSString *)formatter;

/** 时间转字符串*/
+ (NSString *)dateToString:(NSDate *)date formatter:(NSString *)formatter;

/** 将某个时间戳转化成 时间(new) ms毫秒*/
+ (NSString *)timestampToString:(NSInteger)timestamp formatter:(NSString *)formatter isMs:(BOOL)isMs;


/** 字符串转字典*/
+ (NSDictionary *)jsonStringToDictionary:(NSString *)string;

/** 字典转字符串*/
+ (NSString *)dictionaryToJsonString:(NSDictionary *)dict;

/** 字典转 NSData*/
+ (NSData *)dictionaryToData:(NSDictionary *)dict;

/** 联系人汉字转拼音排序*/
+ (NSString *)transformToPinyin:(NSString *)originalString isQuanpin:(BOOL)quanpin;


/**
 * AES 加密
 * content 需要加密的字符串
 * key 密钥
 */
+ (NSString *)encryptAES:(NSString *)content key:(NSString *)key;

/**
 * AES 解密
 * content 需要解密的字符串
 * key 密钥
 */
+ (NSString *)decryptAES:(NSString *)content key:(NSString *)key;

/** 不是缩略图的后面加!400x400变成缩略图*/
+ (NSString *)getImageThumbnailUrl:(NSString *)url;

/** 获取 NSString 字节长度*/
+ (NSInteger)getByteLengthWithString:(NSString *)string;

/** PC 端换行符<br/> 转换成 \n*/
+ (NSString *)brLFToiOSLF:(NSString *)string;

/** PC 端换行符<br/> 转换成空格，会话列表显示更多的换行信息 */
+ (NSString *)brLFToiOSBlank:(NSString *)string;

/** 转发弹窗换行符\n 转换成空格，显示更多的换行信息 */
+ (NSString *)nLFToiOSBlank:(NSString *)string;

/** 小数点向上取整，比如用于视频时长的显示（不是很准）*/
+ (int)getCeilWithFloat:(CGFloat)fValue;

/** 小数点向下取整，比如用于视频时长的显示（不是很准）*/
+ (int)getFloorfWithFloat:(CGFloat)fValue;

/** 小数点四色五入，比如用于视频时长的显示（比较准）*/
+ (int)getRoundfWithFloat:(CGFloat)fValue;


/** 只取数字正则表达式*/
+ (BOOL)onlyTheNumber:(NSString*)string;

/** 判断是否全为数字*/
+ (BOOL)allIsNumber:(NSString *)text;

/// 获取当前 ViewController
+ (UIViewController *)getCurrentVC;

@end

NS_ASSUME_NONNULL_END
