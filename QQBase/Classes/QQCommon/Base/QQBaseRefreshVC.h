//
//  QQBaseRefreshVC.h
//  me
//
//  Created by 子不语 on 2021/12/12.
//  Copyright © 2021 gxrb. All rights reserved.
//

#import "QQBaseVC.h"

/// 空白提示
#import "UIScrollView+EmptyDataSet.h"
/// 下拉加载
#import <MJRefresh/MJRefresh.h>
/// 
#import "QQBaseRefreshModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QQBaseRefreshVC : QQBaseVC

@property (nonatomic, strong) UITableView *qqTableView;
@property (nonatomic, strong) UICollectionView *qqCollectionView;

/** */
@property (nonatomic, strong) QQBaseRefreshModel *refreshModel;
/** */
@property (nonatomic, strong) NSMutableArray *qqDataSource;

/**
 * showFooter 是否使用底部上拉加载
 */
- (void)qqInitRefresh:(id)view model:(QQBaseRefreshModel *)model;

/** 开始下拉*/
- (void)qqBeginRefreshing;

/** 下拉刷新请求数据*/
- (void)qqRequestData;

/** 无下拉请求数据*/
- (void)qqRefresh;

/**
 * 刷新结束
 * 根据已请求的数据和总数据比较判断是否还有数据
 * totalCount 后台数据总数，判断底部状态显示加载更多还是暂无更多数据或隐藏提示
 */
- (void)qqRefreshComplete:(NSArray *)dataSource totalCount:(NSInteger)totalCount;

/**
 * 刷新结束
 * 如果接口有返回总页码的话根据页码判断是否还有数据
 * totalPage 后台数据总页数，判断底部状态显示加载更多还是暂无更多数据或隐藏提示
 */
- (void)qqRefreshComplete:(NSArray *)dataSource totalPage:(NSInteger)totalPage;

/** 停止刷新*/
- (void)qqRequestStop;


@end

NS_ASSUME_NONNULL_END
