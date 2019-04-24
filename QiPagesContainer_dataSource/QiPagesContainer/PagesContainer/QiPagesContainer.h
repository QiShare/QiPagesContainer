//
//  IHStewardHeaderView.h
//  IoTHome
//
//  Created by wangdacheng on 2019/2/22.
//  Copyright © 2019 QiShare. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QiPagesContainerDataSource;
@protocol QiPagesContainerDelegate;

@class QiPagesContainerTopBar;

@interface QiPagesContainer : UIView

@property (nonatomic, weak) id<QiPagesContainerDataSource> dataSource;
@property (nonatomic, weak) id<QiPagesContainerDelegate>delegate;

// 重新载入控件数据
- (void)reloadData;

// 设置所应选择的页，不通知外部
- (void)setDefaultSelectedPageIndex:(NSInteger)index;

// 设置当前选择的页
- (void)setSelectedPageIndex:(NSInteger)index;

// 获取当前的页索引
- (NSInteger)getCurrentPageIndex;

// 获取当前的页pageView
- (UIView *)getCurrentPageView;

// 获取index对应的页pageView
- (UIView *)getPageViewWithIndex:(NSInteger)index;

// 获取顶部的tabBar
- (QiPagesContainerTopBar *)topBar;

// 设置滑块长度色
- (void)setCursorWidth:(CGFloat)width;

// 设置滑块高度
- (void)setCursorHeight:(CGFloat)height;

// 设置滑块的颜色
- (void)setCursorColor:(UIColor *)color;

// 设置相邻button之间的间距，默认值是20
- (void)setButtonMargin:(CGFloat)margin;

// 设置顶部按钮是否靠左显示
- (void)setIsButtonAlignmentLeft:(BOOL)isAlignmentLeft;

// 设置是否显示按钮间分割线
- (void)setShowSeperateLines:(BOOL)showSeperateLines;

// 设置tabBar中各标题未选中/选中时的颜色
- (void)setTitleColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor;

@end


@protocol QiPagesContainerDataSource <NSObject>

@required

// 空间中item的数量
- (NSInteger)numberPageContainder:(QiPagesContainer *)pagesContainer;
// 获取某item的标题
- (NSString *)pageContainder:(QiPagesContainer *)pagesContainer titleForRowAtIndex:(NSInteger)index;
// 获取某item对应的pageView
- (UIView *)pageContainder:(QiPagesContainer *)pagesContainer viewForRowAtIndex:(NSInteger)index;

@end

@protocol QiPagesContainerDelegate <NSObject>

@optional

// 选中某一项
- (void)pageContainder:(QiPagesContainer *)container selectIndex:(NSInteger)index;
// 重复点击选中的某一项
- (void)onClickPageContainder:(QiPagesContainer *)container selectIndex:(NSInteger)index;

@end
