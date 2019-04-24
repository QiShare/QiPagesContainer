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

@property (nonatomic, weak) id<QiPagesContainerTopBarDelegate> delegate;

#pragma mark - setup Style

- (void)setBackgroundImage:(UIImage *)image;

- (void)setBackgroundImageHidden:(BOOL)isHidden;

- (void)setCursorPosition:(CGFloat)percent;

- (void)updateConentWithTitles:(NSArray *)titles;

- (void)setIsButtonAlignmentLeft:(BOOL)isAlignmentLeft;

- (void)setShowSeperateLines:(BOOL)showSeperateLines;

- (void)setButtonMargin:(CGFloat)buttonMargin;

- (void)setSelectedIndex:(NSInteger)idnex;

- (NSInteger)getSelectedIndex;

- (void)setCursorColor:(UIColor *)color;

- (void)setCursorWidth:(CGFloat)width;

- (void)setCursorHeight:(CGFloat)height;

- (void)setTitleColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor;

@end


@protocol QiPagesContainerTopBarDelegate <NSObject>

@optional

// 选中topBar的一项
- (void)topBarSelectIndex:(NSInteger)index;

// 重复点击topBar时会调用该方法
- (void)topBarSelectIndicator:(NSInteger)index;

@end
