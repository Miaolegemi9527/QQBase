//
//  QQBaseRefreshVC.m
//  me
//
//  Created by 子不语 on 2021/12/12.
//  Copyright © 2021 gxrb. All rights reserved.
//

#import "QQBaseRefreshVC.h"

/// 图片加载
#import "UIImage+QQResource.h"

@interface QQBaseRefreshVC ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

/// 空白的时候设置背景色为白色（因为空白提示图背景色为白色），有数据的时候再设置回原来的颜色
@property (nonatomic, strong) UIColor *oldBGColor;

@end

@implementation QQBaseRefreshVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)qqInitRefresh:(id)view model:(QQBaseRefreshModel *)model {
    if (view) {
        // 注意 block 循环引用导致页面无法释放
        QQWeakSelf
        self.refreshModel = model;
        if ([view isKindOfClass:[UITableView class]]) {
            self.qqTableView = view;
            // 空白提示
            self.qqTableView.emptyDataSetSource = self;
            self.qqTableView.emptyDataSetDelegate = self;
            if (self.refreshModel.showHeader) {
                self.qqTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                    [weakSelf qqRefresh];
                }];
            }
            if (self.refreshModel.showFooter) {
                self.qqTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    [weakSelf qqLoadMore];
                }];
                // 没有数据的时候隐藏footer
                self.qqTableView.mj_footer.hidden = YES;
            }
        } else if ([view isKindOfClass:[UICollectionView class]]) {
            self.qqCollectionView = view;
            // 空白提示
            self.qqCollectionView.emptyDataSetSource = self;
            self.qqCollectionView.emptyDataSetDelegate = self;
            if (self.refreshModel.showHeader) {
                self.qqCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                    [weakSelf qqRefresh];
                }];
            }
            if (self.refreshModel.showFooter) {
                self.qqCollectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    [weakSelf qqLoadMore];
                }];
                // 没有数据的时候隐藏footer
                self.qqCollectionView.mj_footer.hidden = YES;
            }
        }
    }
}

/** 上拉加载更多*/
- (void)qqLoadMore {
    self.refreshModel.isRefresh = NO;
    self.refreshModel.page = self.qqDataSource.count / self.refreshModel.pageSize + 1;
    [self qqRequestData];
}
/** 下拉刷新*/
- (void)qqRefresh {
    self.refreshModel.isRefresh = YES;
    self.refreshModel.page = self.refreshModel.pageStart;
    if (self.qqTableView != nil && self.qqTableView.mj_footer != nil) {
        [self.qqTableView.mj_footer resetNoMoreData];
    }
    if (self.qqCollectionView != nil && self.qqCollectionView.mj_footer != nil) {
        [self.qqCollectionView.mj_footer resetNoMoreData];
    }
    [self qqRequestData];
}

- (void)qqBeginRefreshing {
    if (self.qqTableView) {
        [self.qqTableView.mj_header beginRefreshing];
    }
    if (self.qqCollectionView) {
        [self.qqCollectionView.mj_header beginRefreshing];
    }
}

- (void)qqRequestData {
    
}

/**
 * 刷新结束
 * 根据已请求的数据和总数据比较判断是否还有数据
 * totalCount 后台数据总数，判断底部状态显示加载更多还是暂无更多数据或隐藏提示
 */
- (void)qqRefreshComplete:(NSArray *)dataSource totalCount:(NSInteger)totalCount {
    [self qqRefreshComplete:dataSource];
    if (self.qqDataSource.count == totalCount || dataSource.count < self.refreshModel.pageSize) {
        if (self.qqCollectionView && self.qqCollectionView.mj_footer != nil) {
            [self.qqCollectionView.mj_footer endRefreshingWithNoMoreData];
        }
        if (self.qqTableView && self.qqTableView.mj_footer != nil) {
            [self.qqTableView.mj_footer endRefreshingWithNoMoreData];
        }
    }
}

/**
 * 刷新结束
 * 如果接口有返回总页码的话根据页码判断是否还有数据
 * totalPage 后台数据总页数，判断底部状态显示加载更多还是暂无更多数据或隐藏提示
 */
- (void)qqRefreshComplete:(NSArray *)dataSource totalPage:(NSInteger)totalPage {
    [self qqRefreshComplete:dataSource];
    if (self.refreshModel.page > totalPage) {
        if (self.qqCollectionView && self.qqCollectionView.mj_footer != nil) {
            [self.qqCollectionView.mj_footer endRefreshingWithNoMoreData];
        }
        if (self.qqTableView && self.qqTableView.mj_footer != nil) {
            [self.qqTableView.mj_footer endRefreshingWithNoMoreData];
        }
    }
}

- (void)qqRefreshComplete:(NSArray *)dataSource {
    if (self.refreshModel.isRefresh) {
        // 下拉刷新，清空数组，重新赋值
        [self.qqDataSource removeAllObjects];
    }
    if (dataSource) {
        [self.qqDataSource addObjectsFromArray:dataSource];
        
        if (![self.view.backgroundColor isEqual:self.oldBGColor]) {
            self.view.backgroundColor = self.oldBGColor;
        }
    }
    
    if (self.qqTableView) {
        if(self.qqTableView.mj_header==nil && self.qqTableView.mj_footer==nil){
            return;
        }
        if (self.qqTableView.mj_header != nil && self.qqTableView.mj_header.isRefreshing) {
            [self.qqTableView.mj_header endRefreshing];
        }
        if (self.qqTableView.mj_footer != nil) {
            if (self.qqDataSource.count > 0) {
                self.qqTableView.mj_footer.hidden = NO;
            } else {
                self.qqTableView.mj_footer.hidden = YES;
            }
            if (self.qqTableView.mj_footer.isRefreshing) {
                [self.qqTableView.mj_footer endRefreshing];
            }
        }
    }
    
    if (self.qqCollectionView) {
        if(self.qqCollectionView.mj_header==nil && self.qqCollectionView.mj_footer==nil){
            return;
        }
        if (self.qqCollectionView.mj_header != nil && self.qqCollectionView.mj_header.isRefreshing) {
            [self.qqCollectionView.mj_header endRefreshing];
        }
        if (self.qqCollectionView.mj_footer != nil) {
            if (self.qqDataSource.count > 0) {
                self.qqCollectionView.mj_footer.hidden = NO;
            } else {
                self.qqCollectionView.mj_footer.hidden = YES;
            }
            if (self.qqCollectionView.mj_footer.isRefreshing) {
                [self.qqCollectionView.mj_footer endRefreshing];
            }
        }
    }
}

- (void)qqRequestStop {
    if (self.qqTableView) {
        if (self.qqTableView.mj_header != nil && self.qqTableView.mj_header.isRefreshing) {
            [self.qqTableView.mj_header endRefreshing];
        }
        if (self.qqTableView.mj_footer != nil) {
            if (self.qqTableView.mj_footer.isRefreshing) {
                [self.qqTableView.mj_footer endRefreshing];
            }
            self.qqTableView.mj_footer.hidden = self.qqDataSource.count == 0 ? YES : NO;
        }
    }
   
    if (self.qqCollectionView) {
        if (self.qqCollectionView.mj_header != nil && self.qqCollectionView.mj_header.isRefreshing) {
            [self.qqCollectionView.mj_header endRefreshing];
        }
        if (self.qqCollectionView.mj_footer != nil) {
            if (self.qqCollectionView.mj_footer.isRefreshing) {
                [self.qqCollectionView.mj_footer endRefreshing];
            }
            self.qqCollectionView.mj_footer.hidden = self.qqDataSource.count == 0 ? YES : NO;
        }
    }
}

- (NSMutableArray *)qqDataSource {
    if (!_qqDataSource) {
        _qqDataSource = [NSMutableArray array];
    }
    return _qqDataSource;
}

/** 空白提示内容*/
#pragma mark DZNEmptyDataSetSource
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if (!self.oldBGColor) {
        self.oldBGColor = self.view.backgroundColor;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    return [UIImage imageAssetsNamed:@"qq_blank_nothing" bundleName:@"GXEditingCommon"];
}
#pragma mark DZNEmptyDataSetDelegate
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    [self qqBeginRefreshing];
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
