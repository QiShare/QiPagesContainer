//
//  IHStewardHeaderView.h
//  IoTHome
//
//  Created by wangdacheng on 2019/2/22.
//  Copyright © 2019 QiShare. All rights reserved.
//

#import "QiPagesContainer.h"
#import "QiPagesContainerTopBar.h"
#import "QiAllowPanGestureScrollView.h"

#define TOPBAR_HEIGHT  34

@interface QiPagesContainer () <UIScrollViewDelegate, QiPagesContainerTopBarDelegate>

@property (nonatomic, strong) QiPagesContainerTopBar *topBar;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *bottomLineView;

@property (nonatomic, strong) NSArray *arrayViews;
@property (nonatomic, assign) NSInteger currentPageIndex;

@end

@implementation QiPagesContainer

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)init {
    
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    _topBar = [[QiPagesContainerTopBar alloc] initWithFrame:CGRectZero];
    _topBar.target = self;
    [self addSubview:_topBar];

    _scrollView = [[QiAllowPanGestureScrollView alloc] initWithFrame:CGRectZero];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [_scrollView setScrollsToTop:NO];
    [_scrollView setAlwaysBounceHorizontal:NO];
    [_scrollView setAlwaysBounceVertical:NO];
    [_scrollView setBounces:NO];
    [self addSubview:self.scrollView];
    
    [self layoutSubviews];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGSize size = self.frame.size;
    CGFloat scrollViewHeight = size.height - TOPBAR_HEIGHT;
    _topBar.frame = CGRectMake(0, 0, size.width, TOPBAR_HEIGHT);
    _scrollView.frame = CGRectMake(0, TOPBAR_HEIGHT, size.width, scrollViewHeight);
    
    
    for (int i=0; i<[_arrayViews count]; i++) {
        UIView *v = [_arrayViews objectAtIndex:i];
        v.frame = CGRectMake(i*size.width, 0, size.width, scrollViewHeight);
    }
    _scrollView.contentSize = CGSizeMake(size.width * [_arrayViews count], scrollViewHeight);
}

- (void)setButtonMargin:(CGFloat)margin {
    
    _topBar.buttonMargin = margin;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentSize.width > 0) {
        [_topBar setCursorPosition:scrollView.contentOffset.x / scrollView.contentSize.width];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger pageIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (pageIndex != _currentPageIndex) {
        _currentPageIndex = pageIndex;
        [_topBar setSelectedIndex:pageIndex];
        [self notifyDelegateSelectedIndex:pageIndex];
    }
}

#pragma mark - update content
- (void)setDefaultSelectedPageIndex:(NSInteger)index {
    
    if (index >= 0 && index <= [_arrayViews count] && index != _currentPageIndex) {
        [_topBar setSelectedIndex:index];
        _currentPageIndex = index;
        
        [_scrollView setContentOffset:CGPointMake(index * _scrollView.frame.size.width, 0) animated:YES];
    }
}

- (void)setSelectedPageIndex:(NSInteger)index {
    
    if (index >= 0 && index <= [_arrayViews count] && index != _currentPageIndex) {
        [_topBar setSelectedIndex:index];
        [self topBarSelectIndex:index];
    }
}

- (NSInteger)getCurrentPageIndex {
    
    return [_topBar getSelectedIndex];
}

- (UIView *)getCurrentPageView {
    
    return [_arrayViews objectAtIndex:[_topBar getSelectedIndex]];
}

- (UIView *)getPageViewWithIndex:(NSInteger)index {
    
    if (index<[_arrayViews count]) {
        return [_arrayViews objectAtIndex:index];
    } else {
        return nil;
    }
}

- (void)updateContentWithTitles:(NSArray *)titles {
    
    [_topBar updateConentWithTitles:titles];
}

- (void)setIsButtonAlignmentLeft:(BOOL)isAlignmentLeft {
    
    [_topBar setIsButtonAlignmentLeft:isAlignmentLeft];
}

- (void)setShowSeperateLines:(BOOL)showSeperateLines {
    
    [_topBar setShowSeperateLines:showSeperateLines];
}

- (void)updateContentWithViews:(NSArray *)views {
    
    for (UIView *view in _arrayViews) {
        [view removeFromSuperview];
    }
    if ([views count] == 0) {
        return;
    }
    _arrayViews = [NSArray arrayWithArray:views];
    
    for (int i=0; i<[views count]; i++) {
        UIView *view = [views objectAtIndex:i];
        [_scrollView addSubview:view];
    }
    [self layoutSubviews];
}

#pragma mark - QIPagesContainerTopBarDelegate
- (void)topBarSelectIndex:(NSInteger)index {
    
    if (index < [_arrayViews count]) {
        _currentPageIndex = index;

        [_scrollView setContentOffset:CGPointMake(index * _scrollView.frame.size.width, 0) animated:YES];
        [self notifyDelegateSelectedIndex:index];
    }
}
/** 重复点击topBar时会调用该方法 */
- (void)topBarSelectIndicator:(NSInteger)index {
    
    if (index < [_arrayViews count]) {
        _currentPageIndex = index;
        [_scrollView setContentOffset:CGPointMake(index * _scrollView.frame.size.width, 0) animated:YES];

        if (_delegate && [_delegate respondsToSelector:@selector(onClickPageIndicator:selectIndex:)]) {
            [_delegate onClickPageIndicator:self selectIndex:index];
        }

    }
}

- (void)notifyDelegateSelectedIndex:(NSInteger )index {
    
    if (_delegate && [_delegate respondsToSelector:@selector(pageContainder:selectIndex:)]) {
        [_delegate pageContainder:self selectIndex:index];
    }
}

#pragma mark - set badge
- (void)setBadgeText:(NSString *)badgeText atIndex:(NSInteger)index {
    
    [_topBar setBadgeText:badgeText atIndex:index];
}

- (void)hideBadgeAtIndex:(NSInteger)index {
    
    [_topBar hideBadgeAtIndex:index];
}

#pragma mark - 设置按钮选中和未选中的颜色
- (void)setTextColor:(UIColor *)normalColor andSelectedColor:(UIColor *)selectedColor {
    
    [_topBar setTextColor:normalColor andSelectedColor:selectedColor];
}

#pragma mark - 设置滑块的颜色
- (void)setCursorColor:(UIColor *)color {
    
    [_topBar setCursorColor:color];
}

#pragma mark - 设置滑块长度
- (void)setCursorWidth:(CGFloat)width {
    
    [_topBar setCursorWidth:width];
}

#pragma mark - 设置滑块长度
- (void)setCursorHeight:(CGFloat)height {
    
    [_topBar setCursorHeight:height];
}

#pragma mark 设置指示器 默认在右侧 -
/** 设置其中一项的指示图片 文字右侧 */
- (void)imageIndicatorNamed:(NSString*)imgName atIndex:(NSInteger)index{
    [_topBar setImageIndicatorNamed:imgName atIndex:index];
}

#pragma mark - 获取顶部的tabBar 
- (QiPagesContainerTopBar*)topBar{
    return _topBar;
}

@end
