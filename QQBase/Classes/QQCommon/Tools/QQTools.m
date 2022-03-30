//
//  QQTools.m
//  me
//
//  Created by 子不语 on 2022/1/13.
//  Copyright © 2022 gxrb. All rights reserved.
//

#import "QQTools.h"

/** AES 加密*/
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

@implementation QQTools

/** MD5 加密或者将特殊字符转(如群ID)成可以正常当做表名的字符串*/
+ (NSString *)stringToMd5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

/** 时间戳转字符串*/
+ (NSString *)timestampToString:(NSInteger)timestamp formatter:(NSString *)formatter {
    //NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp longLongValue]/1000];// 毫秒
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:formatter?:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

/** 时间戳转时间*/
+ (NSDate *)timestampToDate:(NSInteger)timestamp formatter:(NSString *)formatter {
    NSString *string = [self timestampToString:timestamp formatter:formatter];
    return [self stringToDate:string formatter:formatter];
}

/** 时间转时间戳*/
+ (NSString *)dateToTimestamp:(NSDate *)date {
    //NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970*1000]];// 毫秒
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return timeSp;
}

/** 字符串转时间*/
+ (NSDate *)stringToDate:(NSString *)dateStr formatter:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter?:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datestr = [dateFormatter dateFromString:dateStr];
    return datestr;
}

/** 字符串转时间，转换不会有时差的问题*/
+ (NSDate *)stringToUTCDate:(NSString *)dateStr formatter:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter?:@"YYYY-MM-dd HH:mm:ss"];
    /// 解决转换后有时差的问题
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    return [dateFormatter dateFromString:dateStr];
}

/** 字符串转时间戳*/
+ (NSInteger)stringToTimestamp:(NSString *)dateStr formatter:(NSString *)formatter {
    return [[self dateToTimestamp:[self stringToDate:dateStr formatter:formatter]] integerValue];
}

/** 时间转字符串*/
+ (NSString *)dateToString:(NSDate *)date formatter:(NSString *)formatter {
    NSString *timestamp = [self dateToTimestamp:date];
    return [self timestampToString:[timestamp integerValue] formatter:formatter];
}

/** 将某个时间戳转化成 时间(new) ms毫秒*/
+ (NSString *)timestampToString:(NSInteger)timestamp formatter:(NSString *)formatter isMs:(BOOL)isMs {
    
    NSDateFormatter *tempFormatter = [[NSDateFormatter alloc] init];
    
    [tempFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    [tempFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    [tempFormatter setDateFormat:formatter]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [tempFormatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:isMs?timestamp/1000:timestamp];
    NSString *confromTimespStr = [tempFormatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
    
}

/** 字符串转字典*/
+ (NSDictionary *)jsonStringToDictionary:(NSString *)string {
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (error) {
      //解析出错
        return nil;
    }
    return dic;
}

/** 字典转字符串*/
+ (NSString *)dictionaryToJsonString:(NSDictionary *)dict {
    NSError *parseError;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&parseError];
    if (parseError) {
      //解析出错
        return nil;
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

/** 字典转 NSData*/
+ (NSData *)dictionaryToData:(NSDictionary *)dict {
    NSError *error = nil;
    return [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
}

+ (NSString *)transformToPinyin:(NSString *)originalString isQuanpin:(BOOL)quanpin {
    NSMutableString *muStr = [NSMutableString stringWithString:originalString];
    //汉字转成拼音
    CFStringTransform((CFMutableStringRef)muStr, NULL, kCFStringTransformMandarinLatin, NO);
    //去掉音标
    CFStringTransform((CFMutableStringRef)muStr, NULL, kCFStringTransformStripDiacritics, NO);
    NSArray *pinyinArray = [muStr componentsSeparatedByString:@" "];
    NSMutableString *allString = [NSMutableString new];
    if (quanpin) {
        int count = 0;
        for (int i = 0; i < pinyinArray.count; i++) {
            for (int i = 0; i < pinyinArray.count; i++) {
                if (i == count) {
                    [allString appendString:@"#"];
                }
                [allString appendFormat:@"%@",pinyinArray[i]];
            }
            [allString appendString:@","];
            count++;
        }
    }
    NSMutableString *initialStr = [NSMutableString new];
    for (NSString *str in pinyinArray) {
        if ([str length] > 0) {
            [initialStr appendString:[str substringFromIndex:1]];
        }
    }
    [allString appendFormat:@"#%@",initialStr];
    [allString appendFormat:@",#%@",originalString];
    return allString;
}


/**
 * 初始向量使用除ECB以外的其他加密模式均需要传入一个初始向量，其大小与Block Size相等（AES的Block Size为128 bits），而三端API均指明当不传入初始向量时，系统将默认使用一个全0的初始向量
 * 偏移量（IV）：非必须的，不过如果想加的话规则同上：“保持一致”；
 */
NSString *const kAESInitVector = @"a7c-a7A-kHz-XiAa";

/**
 * 密钥
 * AES-128，128位16字节即传入的密钥 key 需为长度为16 的字符串
 */
NSString *const kAESKey = @"ShB-KTG-A83-dnHb";

/**
 * 密钥长度 128、256
 * AES-128，128位16字节即传入的密钥 key 需为长度为16 的字符串
 */
size_t const kAESKeySize = kCCKeySizeAES128;

/**
 * AES 加密
 * content 需要加密的字符串
 * key 密钥
 */
+ (NSString *)encryptAES:(NSString *)content key:(NSString *)key {

    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = contentData.length;
    // 为结束符'\0' +1
    char keyPtr[kAESKeySize + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key?:kAESKey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    // 密文长度 <= 明文长度 + BlockSize
    size_t encryptSize = dataLength + kCCBlockSizeAES128;
    void *encryptedBytes = malloc(encryptSize);
    size_t actualOutSize = 0;
    NSData *initVector = [kAESInitVector dataUsingEncoding:NSUTF8StringEncoding];

    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding, // 系统默认使用 CBC&#xff0c;然后指明使用 PKCS7Padding
                                          keyPtr,
                                          kAESKeySize,
                                          initVector.bytes,
                                          contentData.bytes,
                                          dataLength,
                                          encryptedBytes,
                                          encryptSize,
                                          &actualOutSize);



    if (cryptStatus == kCCSuccess) {
        // 对加密后的数据进行 base64 编码
        return [[NSData dataWithBytesNoCopy:encryptedBytes length:actualOutSize] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }
    free(encryptedBytes);
    return nil;
}

/**
 * AES 解密
 * content 需要解密的字符串
 * key 密钥
 */
+(NSString *)decryptAES:(NSString *)content key:(NSString *)key {
    
    // https://www.jianshu.com/p/cd9939319365
    // 安卓加密不对齐又没有等号解密失败的问题
    // 解码时如果发现Base64编码字符串长度不能被4整除，则先补充 = 字符，再解码即可，否则可能解密失败
    if (content.length%4 != 0) {
        // 求4的余数，不够4整除的补等号=
        NSInteger equalSignNumber = 4-(content.length%4);
        NSMutableString *equalSignStr = [NSMutableString string];
        for (NSInteger i = 0; i < equalSignNumber; i++) {
            [equalSignStr appendFormat:@"="];
        }
        content = [NSString stringWithFormat:@"%@%@",content,equalSignStr];
    }
    
    // 把 base64 String 转换成 Data
    NSData *contentData = [[NSData alloc] initWithBase64EncodedString:content options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSUInteger dataLength = contentData.length;
    char keyPtr[kAESKeySize + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key?:kAESKey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    size_t decryptSize = dataLength + kCCBlockSizeAES128;
    void *decryptedBytes = malloc(decryptSize);
    size_t actualOutSize = 0;
    NSData *initVector = [kAESInitVector dataUsingEncoding:NSUTF8StringEncoding];
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kAESKeySize,
                                          initVector.bytes,
                                          contentData.bytes,
                                          dataLength,
                                          decryptedBytes,
                                          decryptSize,
                                          &actualOutSize);
    if (cryptStatus == kCCSuccess) {
        return [[NSString alloc] initWithData:[NSData dataWithBytesNoCopy:decryptedBytes length:actualOutSize] encoding:NSUTF8StringEncoding];
    }
    free(decryptedBytes);
    return nil;
}

/** 判断是不是缩略图，目前是判断有没有 ！号*/
+ (BOOL)isImageThumbnailUrl:(NSString *)url {
    BOOL value = NO;
    if ([url containsString:@"!"]) {
        value = YES;
    }
    return value;
}
/** 不是缩略图的后面加!400x400变成缩略图*/
+ (NSString *)getImageThumbnailUrl:(NSString *)url {
    NSString *value = url;
    if (![self isImageThumbnailUrl:url]) {
        // zby 缩略图用 x 不是用 *，用 * 不显示
        value = [NSString stringWithFormat:@"%@!400x400",url];
    }
    return value;
}

/** 获取 NSString 字节长度*/
+ (NSInteger)getByteLengthWithString:(NSString *)string {
    NSInteger value = 0;
    char * p = (char *)[string cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[string lengthOfBytesUsingEncoding:NSUnicodeStringEncoding];i++) {
        if (*p) {
            p++;
            value++;
        } else {
            p++;
        }
    }
    return (value+1)/2;
}

/** PC 端换行符<br/> 转换成 \n*/
+ (NSString *)brLFToiOSLF:(NSString *)string {
    if ([string containsString:@"<br/>"]) {
        return [string stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
    }
    return string;
}

/** PC 端换行符<br/> 转换成空格，会话列表显示更多的换行信息 */
+ (NSString *)brLFToiOSBlank:(NSString *)string {
    if ([string containsString:@"<br/>"]) {
        return [string stringByReplacingOccurrencesOfString:@"<br/>" withString:@"  "];
    }
    return string;
}

/** 转发弹窗换行符\n 转换成空格，显示更多的换行信息 */
+ (NSString *)nLFToiOSBlank:(NSString *)string {
    if ([string containsString:@"\n"]) {
        return [string stringByReplacingOccurrencesOfString:@"\n" withString:@"  "];
    }
    return string;
}


/** 小数点向上取整，比如用于视频时长的显示（不是很准）*/
+ (int)getCeilWithFloat:(CGFloat)fValue {
    // 向上取整
    CGFloat value = ceilf(fValue);
    return (int)value;
}

/** 小数点向下取整，比如用于视频时长的显示（不是很准）*/
+ (int)getFloorfWithFloat:(CGFloat)fValue {
    // 向下取整
    CGFloat value = floorf(fValue);
    return (int)value;
}

/** 小数点四色五入，比如用于视频时长的显示（比较准）*/
+ (int)getRoundfWithFloat:(CGFloat)fValue {
    // 四舍五入
    CGFloat value = roundf(fValue);
    return (int)value;
}

/** 只取数字正则表达式*/
+ (BOOL)onlyTheNumber:(NSString*)string {
    NSString *numString =@"[0-9]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numString];
    BOOL inputString = [predicate evaluateWithObject:string];
    return inputString;
}

/** 判断是否全为数字*/
+ (BOOL)allIsNumber:(NSString *)text {
    NSString *regex =@"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if (![pred evaluateWithObject:text]) {
        return NO;
    }
    return YES;
}

/// 获取当前 ViewController
+ (UIViewController *)getCurrentVC {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [self getCurrentVCFrom:[rootVC presentedViewController]];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

@end
