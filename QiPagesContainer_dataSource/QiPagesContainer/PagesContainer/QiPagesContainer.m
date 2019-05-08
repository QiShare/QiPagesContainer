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

@property (nonatomic, strong) NSArray *viewArr;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, assign) NSInteger currentPageIndex;

@end

@implementation QiPagesContainer

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    
    _topBar = [[QiPagesContainerTopBar alloc] initWithFrame:CGRectZero];
    _topBar.delegate = self;
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
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGSize size = self.frame.size;
    CGFloat scrollViewHeight = size.height - TOPBAR_HEIGHT;
    _topBar.frame = CGRectMake(0, 0, size.width, TOPBAR_HEIGHT);
    _scrollView.frame = CGRectMake(0, TOPBAR_HEIGHT, size.width, scrollViewHeight);
    
    for (int i=0; i<[_viewArr count]; i++) {
        UIView *v = [_viewArr objectAtIndex:i];
        v.frame = CGRectMake(i*size.width, 0, size.width, scrollViewHeight);
    }
    _scrollView.contentSize = CGSizeMake(size.width * [_viewArr count], scrollViewHeight);
}

- (void)didMoveToSuperview {
    
    [self reloadData];
}

- (void)reloadData {
    
    _currentPageIndex = 0;
    for (UIView *view in _viewArr) {
        [view removeFromSuperview];
    }
    
    NSMutableArray *tViewArr = [NSMutableArray array];
    NSMutableArray *tTitleArr = [NSMutableArray array];
    NSInteger count = [self.dataSource numberPageContainder:self];
    for (int idx=0; idx<count; idx++) {
        UIView *view = [self.dataSource pageContainder:self viewForRowAtIndex:idx];
        [tViewArr addObject:view];
        NSString *title = [self.dataSource pageContainder:self titleForRowAtIndex:idx];
        [tTitleArr addObject:title];
        [_scrollView addSubview:view];
    }
    
    _viewArr = [NSArray arrayWithArray:tViewArr];
    _titleArr = [NSArray arrayWithArray:tTitleArr];
    [_topBar updateConentWithTitles:_titleArr];
    
    [self layoutSubviews];
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


#pragma mark - QIPagesContainerTopBarDelegate

- (void)topBarSelectIndex:(NSInteger)index {
    
    if (index < [_viewArr count]) {
        _currentPageIndex = index;

        [_scrollView setContentOffset:CGPointMake(index * _scrollView.frame.size.width, 0) animated:YES];
        [self notifyDelegateSelectedIndex:index];
    }
}

- (void)topBarSelectIndicator:(NSInteger)index {
    
    if (index < [_viewArr count]) {
        _currentPageIndex = index;
        [_scrollView setContentOffset:CGPointMake(index * _scrollView.frame.size.width, 0) animated:YES];

        if (_delegate && [_delegate respondsToSelector:@selector(onClickPageContainder:selectIndex:)]) {
            [_delegate onClickPageContainder:self selectIndex:index];
        }
    }
}

- (void)notifyDelegateSelectedIndex:(NSInteger )index {
    
    if (_delegate && [_delegate respondsToSelector:@selector(pageContainder:selectIndex:)]) {
        [_delegate pageContainder:self selectIndex:index];
    }
}


#pragma mark - 设置、获取selectedPageIndex和pageView

- (void)setDefaultSelectedPageIndex:(NSInteger)index {
    
    if (index >= 0 && index <= [_viewArr count] && index != _currentPageIndex) {
        [_topBar setSelectedIndex:index];
        _currentPageIndex = index;
        
        [_scrollView setContentOffset:CGPointMake(index * _scrollView.frame.size.width, 0) animated:YES];
    }
}

- (void)setSelectedPageIndex:(NSInteger)index {
    
    if (index >= 0 && index <= [_viewArr count] && index != _currentPageIndex) {
        [_topBar setSelectedIndex:index];
        [self topBarSelectIndex:index];
    }
}

- (NSInteger)getCurrentPageIndex {
    
    return [_topBar getSelectedIndex];
}

- (UIView *)getCurrentPageView {
    
    return [_viewArr objectAtIndex:[_topBar getSelectedIndex]];
}

- (UIView *)getPageViewWithIndex:(NSInteger)index {
    
    if (index<[_viewArr count]) {
        return [_viewArr objectAtIndex:index];
    } else {
        return nil;
    }
}


#pragma mark - 设置topBar风格样式

- (QiPagesContainerTopBar*)topBar {
    
    return _topBar;
}

- (void)setCursorWidth:(CGFloat)width {
    
    [_topBar setCursorWidth:width];
}

- (void)setCursorHeight:(CGFloat)height {
    
    [_topBar setCursorHeight:height];
}

- (void)setCursorColor:(UIColor *)color {
    
    [_topBar setCursorColor:color];
}

- (void)setButtonMargin:(CGFloat)margin {
    
    [_topBar setButtonMargin:margin];
}

- (void)setIsButtonAlignmentLeft:(BOOL)isAlignmentLeft {
    
    [_topBar setIsButtonAlignmentLeft:isAlignmentLeft];
}

- (void)setShowSeperateLines:(BOOL)showSeperateLines {
    
    [_topBar setShowSeperateLines:showSeperateLines];
}

- (void)setTitleColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor {
    
    [_topBar setTitleColor:normalColor selectedColor:selectedColor];
}

@end
