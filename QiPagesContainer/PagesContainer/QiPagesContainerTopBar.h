//
//  IHStewardHeaderView.h
//  IoTHome
//
//  Created by wangdacheng on 2019/2/22.
//  Copyright © 2019 QiShare. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QiPagesContainerTopBarDelegate;

@interface QiPagesContainerTopBar : UIView

@property (nonatomic, assign) id<QiPagesContainerTopBarDelegate> target;

// 设置相邻button之间的间距(两个button的title之间的距离）
@property (nonatomic, assign) CGFloat buttonMargin;

#pragma mark - update style

- (void)setBackgroundImage:(UIImage *)image;

- (void)setBackgroundImageHidden:(BOOL)isHidden;

- (void)setCursorPosition:(CGFloat)percent;

- (void)updateConentWithTitles:(NSArray *)titles;

- (void)setIsButtonAlignmentLeft:(BOOL)isAlignmentLeft;

- (void)setShowSeperateLines:(BOOL)showSeperateLines;

- (void)setSelectedIndex:(NSInteger)idnex;

- (NSInteger)getSelectedIndex;

- (void)setBadgeText:(NSString *)badgeText atIndex:(NSInteger)index;

- (void)hideBadgeAtIndex:(NSInteger)index;

// 设置滑块的颜色
- (void)setCursorColor:(UIColor *)color;
// 设置滑块长度
- (void)setCursorWidth:(CGFloat)width;
// 设置滑块长度
- (void)setCursorHeight:(CGFloat)height;

// 设置按钮选中和未选中的颜色
- (void)setTextColor:(UIColor *)normalColor andSelectedColor:(UIColor *)selectedColor;

// 获取文字右侧指示器图片名称
- (NSString*)getImageIndicatorNameWithIndex:(NSInteger)index;
// 设置按钮的指示标志
- (void)setImageIndicatorNamed:(NSString*)imgName atIndex:(NSInteger)index;
// 设置按钮的指示标志
- (void)setImageIndicatorNamed:(NSString*)firstImgName,  ... NS_REQUIRES_NIL_TERMINATION;

@end


@protocol QiPagesContainerTopBarDelegate <NSObject>

@optional
// 选中topBar的一项
- (void)topBarSelectIndex:(NSInteger)index;

// 重复点击topBar时会调用该方法
- (void)topBarSelectIndicator:(NSInteger)index;

@end
