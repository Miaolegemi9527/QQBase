//
//  QQBaseRefreshModel.h
//  me
//
//  Created by 子不语 on 2021/12/12.
//  Copyright © 2021 gxrb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QQBaseRefreshModel : NSObject

/** 状态 YES：下拉刷新；NO：上拉加载*/
@property (nonatomic, assign) BOOL isRefresh;
/** 是否开启下拉刷新*/
@property (nonatomic, assign) BOOL showHeader;
/** 是否开启上拉加载*/
@property (nonatomic, assign) BOOL showFooter;
/** 页数 从0开始还是1开始*/
@property (nonatomic, assign) NSInteger pageStart;
/** 页数 累计叠加*/
@property (nonatomic, assign) NSInteger page;
/** 每页数量*/
@property (nonatomic, assign) NSInteger pageSize;
/** */
@property (nonatomic, copy) NSString *viewClass;

@end

NS_ASSUME_NONNULL_END
