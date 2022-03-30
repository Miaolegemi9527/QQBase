//
//  QQBaseTableViewCell.h
//  me
//
//  Created by 子不语 on 2021/12/8.
//  Copyright © 2021 gxrb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 在声明一个属性的时候加上 __nullable（？可以为空）与__nonnull（！不能为空） 如果放在@property里面的话不用写下划线
typedef void (^QQTCellBackBlock)(id __nullable params, id __nullable data);

@interface QQBaseTableViewCell : UITableViewCell

/** 事件等回调*/
@property (nonatomic, copy) QQTCellBackBlock qqBlock;
/** 赋值*/
@property (nonatomic, copy) NSDictionary *dataDict;

@end

NS_ASSUME_NONNULL_END
