//
//  IHStewardHeaderView.h
//  IoTHome
//
//  Created by wangdacheng on 2019/2/22.
//  Copyright © 2019 QiShare. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QiPagesContainerDelegate;
@class QiPagesContainerTopBar;

@interface QiPagesContainer : UIView

@property (nonatomic, weak) id<QiPagesContainerDelegate>delegate;

/**
 设置相邻button之间的间距。间距是从该button的文字结束到下个button的文字开始之间的距离
 默认值是20
 */
- (void)setButtonMargin:(CGFloat)margin;

/**
 设置顶部的标题
 */
- (void)updateContentWithTitles:(NSArray *)titles;

/**
 设置顶部按钮位置
 */
- (void)setIsButtonAlignmentLeft:(BOOL)isAlignmentLeft;

/*!
 设置是否显示按钮间分割线
 */
- (void)setShowSeperateLines:(BOOL)showSeperateLines;

/**
 设置底部的View，每个View会占据该容器的大小
 */
- (void)updateContentWithViews:(NSArray *)views;

/**
 设置所应选择的页，不通知外部
 */
- (void)setDefaultSelectedPageIndex:(NSInteger)index;

/**
 设置所应选择的页
 */
- (void)setSelectedPageIndex:(NSInteger)index;

/**
 得到当前的页面
 */
- (NSInteger)getCurrentPageIndex;

/**
 得到当前正在显示的view
 */
- (UIView *)getCurrentPageView;

/**
 得到index对应的view
 */
- (UIView *)getPageViewWithIndex:(NSInteger)index;

/**
 获取顶部的tabBar
 */
- (QiPagesContainerTopBar*)topBar;

/**
 设置按钮选中和未选中的颜色
 */ 
- (void)setTextColor:(UIColor *)normalColor andSelectedColor:(UIColor *)selectedColor;

// 设置滑块的颜色
- (void)setCursorColor:(UIColor *)color;
// 设置滑块长度
- (void)setCursorWidth:(CGFloat)width;
// 设置滑块长度
- (void)setCursorHeight:(CGFloat)height;

@end


@protocol QiPagesContainerDelegate <NSObject>

@optional
/** page切换 */
- (void)pageContainder:(QiPagesContainer *)container selectIndex:(NSInteger)index;

/** 点击当前的指示器 */
- (void)onClickPageIndicator:(QiPagesContainer *)container selectIndex:(NSInteger)index;

@end
