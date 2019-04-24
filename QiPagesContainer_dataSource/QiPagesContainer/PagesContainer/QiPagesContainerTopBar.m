//
//  IHStewardHeaderView.h
//  IoTHome
//
//  Created by wangdacheng on 2019/2/22.
//  Copyright © 2019 QiShare. All rights reserved.
//

#import "QiPagesContainerTopBar.h"
#import "QiTopBarButton.h"

//左右侧的间距
#define MARGIN_HORI (0)
#define CursorHeightDefault (1.5)
#define BUTTON_MARGIN_DEFAULT   (20)

@interface QiPagesContainerTopBar ()

@property (nonatomic, strong) UIImageView *bacImgView;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *cursor;
@property (nonatomic, assign) CGFloat cursorWidth;
@property (nonatomic, assign) CGFloat cursorHeight;

@property (nonatomic, assign) CGFloat buttonMargin;
@property (nonatomic, strong) NSArray *arrayButtons;
@property (nonatomic, strong) NSArray *seperateLineArr;
@property (nonatomic, assign) BOOL showSeperateLines;
@property (nonatomic, assign) BOOL isButtonAlignmentLeft;

@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;

@end

@implementation QiPagesContainerTopBar

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    
    _buttonMargin = BUTTON_MARGIN_DEFAULT;
    _cursorHeight = CursorHeightDefault;
    
    _bacImgView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:_bacImgView];
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    [self addSubview:_scrollView];
    
    _cursor = [[UIView alloc] initWithFrame:CGRectZero];
    _cursor.backgroundColor = [UIColor redColor];
    _cursor.layer.cornerRadius = _cursorHeight / 2.0;
    [_scrollView addSubview:_cursor];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGSize size = self.frame.size;
    _bacImgView.frame = CGRectMake(0, 0, size.width, size.height);;
    _scrollView.frame = CGRectMake(0, 0, size.width, size.height);
    if ([_arrayButtons count] == 0) { return; }
    
    // 增加按钮两侧的间距
    CGFloat contentWidth = MARGIN_HORI * 2;
    for (int i=0; i<[_arrayButtons count]; i++) {
        UIButton *button = [_arrayButtons objectAtIndex:i];
        contentWidth += button.frame.size.width;
    }
    
    // 按钮未排满整屏宽度时
    if (!_isButtonAlignmentLeft && contentWidth < size.width) {
        CGFloat buttonWidth = floorf((size.width - MARGIN_HORI * 2) / [_arrayButtons count]);
        for (UIButton *button in _arrayButtons) {
            CGRect frame = button.frame;
            frame.size.width = buttonWidth;
            button.frame = frame;
        }
    }
    
    // 设置按钮位置
    NSInteger selectedIndex = 0;
    CGFloat xOffset = MARGIN_HORI;
    CGFloat buttonHeight = size.height;
    for (int i=0; i<[_arrayButtons count]; i++) {
        UIButton *button = [_arrayButtons objectAtIndex:i];
        CGRect frame = button.frame;
        frame.origin.x = xOffset;
        frame.origin.y = 0;
        frame.size.height = buttonHeight;
        button.frame = frame;
        xOffset += frame.size.width;
        if (button.selected) {
            selectedIndex = i;
        }
    }
    
    // 设置分割线位置
    for (int i=0; i<[_seperateLineArr count]; i++) {
        UIView *line = [_seperateLineArr objectAtIndex:i];
        line.hidden = !_showSeperateLines;
        
        UIButton *buttonPrev = [_arrayButtons objectAtIndex:i];
        UIButton *buttonNext = [_arrayButtons objectAtIndex:i+1];
        
        CGRect frame = line.frame;
        frame.origin.x = (CGRectGetMaxX(buttonPrev.frame) + CGRectGetMinX(buttonNext.frame))/2;
        line.frame = frame;
        
    }
    
    _scrollView.contentSize = CGSizeMake(xOffset + MARGIN_HORI, size.height);
    
    // 设置游标位置
    UIButton *buttonSelected = [_arrayButtons objectAtIndex:selectedIndex];
    CGRect frame = buttonSelected.frame;
    [buttonSelected.titleLabel sizeToFit];
    CGFloat cursorWidth = _cursorWidth != 0 ? _cursorWidth : buttonSelected.titleLabel.frame.size.width;
    _cursor.frame = CGRectMake(frame.origin.x + (frame.size.width - cursorWidth) / 2, CGRectGetMaxY(frame) - _cursorHeight, cursorWidth, _cursorHeight);
}


#pragma mark - 创建各个button

- (void)updateConentWithTitles:(NSArray *)titles {
    
    for (UIButton *button in _arrayButtons) {
        [button removeFromSuperview];
    }
    for (UIView *seperateLine in _seperateLineArr) {
        [seperateLine removeFromSuperview];
    }
    if ([titles count] == 0) { return; }
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i=0; i<[titles count]; i++) {
        NSString *title = [titles objectAtIndex:i];
        UIButton *button = [self createCustomButtonWithTitle:title];
        button.tag = i;
        [button sizeToFit];
        CGRect frame = button.frame;
        frame.size.width += _buttonMargin;
        button.frame = frame;
        [_scrollView addSubview:button];
        [tempArray addObject:button];
    }
    _arrayButtons = [NSArray arrayWithArray:tempArray];
    [_scrollView bringSubviewToFront:_cursor];
    [self setSelectedIndex:0];
    
    CGFloat lineTop = CGRectGetHeight(self.frame) / 5;
    CGFloat lineHeight = CGRectGetHeight(self.frame) - lineTop * 2;
    tempArray = [NSMutableArray array];
    for (int i=0; i<[_arrayButtons count]-1; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, lineTop, 0.8, lineHeight)];
        line.backgroundColor = [UIColor lightGrayColor];
        [_scrollView addSubview:line];
        [tempArray addObject:line];
    }
    _seperateLineArr = [NSArray arrayWithArray:tempArray];
    
    [self setNeedsLayout];
}

- (UIButton *)createCustomButtonWithTitle:(NSString *)title {
    
    UIButton *button = [[QiTopBarButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    if (_normalColor && _selectedColor) {
        [button setTitleColor:_normalColor forState:UIControlStateNormal];
        [button setTitleColor:_selectedColor forState:UIControlStateSelected];
    }
    return button;
}

- (void)buttonClicked:(UIButton *)button {
    
    NSInteger tag = button.tag;
    
    if (button.selected) {
        if (_delegate && [_delegate respondsToSelector:@selector(topBarSelectIndicator:)]) {
            [_delegate topBarSelectIndicator:tag];
        }
        return;
    }

    [self setSelectedIndex:tag];
    if (_delegate && [_delegate respondsToSelector:@selector(topBarSelectIndex:)]) {
        [_delegate topBarSelectIndex:tag];
    }
}


#pragma mark - 属性设置
- (void)setSelectedIndex:(NSInteger)index {
    
    if (index > [_arrayButtons count]) {
        return;
    }
    
    for (int i=0; i<[_arrayButtons count]; i++) {
        UIButton *button = [_arrayButtons objectAtIndex:i];
        button.selected = (i == index);
    }
    [self updateScrollViewPosition];
}

- (NSInteger)getSelectedIndex {
    
    NSInteger selectedIndex = 0;
    for (int i=0; i<[_arrayButtons count]; i++) {
        UIButton *button = [_arrayButtons objectAtIndex:i];
        if (button.selected) {
            selectedIndex = i;
        }
    }
    return selectedIndex;
}

- (void)scrollRectToCenter:(CGRect)frame {
    
    CGSize size = self.frame.size;
    CGSize contentSize = self.scrollView.contentSize;
    
    CGFloat targetX = frame.origin.x - (size.width - frame.size.width) / 2;
    CGFloat targetEndX = targetX + size.width;
    
    if (targetX < 0) {
        targetX = 0;
    }
    if (targetEndX > contentSize.width) {
        targetEndX = contentSize.width;
    }
    CGRect targetRect = CGRectMake(targetX, 0, targetEndX - targetX, frame.size.height);
    
    [self.scrollView scrollRectToVisible:targetRect animated:YES];
}

- (void)updateScrollViewPosition {
    
    CGSize size = self.frame.size;
    CGSize contentSize = self.scrollView.contentSize;
    if (size.width >= contentSize.width) {
        return;
    }
    
    CGRect frame = CGRectZero;
    for (int i=0; i<[_arrayButtons count]; i++) {
        UIButton *button = [_arrayButtons objectAtIndex:i];
        if (button.selected) {
            frame = button.frame;
        }
    }
    
    [self scrollRectToCenter:frame];
}

- (void)setCursorPosition:(CGFloat)percent {
    
    CGFloat indexOffset = percent * [_arrayButtons count];
    NSInteger preIndex = floorf(indexOffset);
    NSInteger nextIndex = ceilf(indexOffset);
    
    if (preIndex >= 0 && nextIndex <= [_arrayButtons count]) {
        UIButton *preBtn = [_arrayButtons objectAtIndex:preIndex];
        UIButton *nextBtn = [_arrayButtons objectAtIndex:nextIndex];
        
        CGFloat cursorWidth = _cursorWidth;
        if (cursorWidth == 0) {
            cursorWidth = preBtn.titleLabel.frame.size.width + (indexOffset - preIndex) * (nextBtn.titleLabel.frame.size.width - preBtn.titleLabel.frame.size.width);
            CGRect frame = _cursor.frame;
            frame.size.width = cursorWidth;
            _cursor.frame = frame;
        }
        
        CGFloat cursorCenterX = preBtn.center.x + (indexOffset - preIndex) * (nextBtn.center.x - preBtn.center.x);
        _cursor.center = CGPointMake(cursorCenterX , _cursor.center.y);
    }
}

- (QiTopBarButton *)getCustomButtonAtIndex:(NSInteger)index {
    
    if (index >= 0 && index < [_arrayButtons count]) {
        QiTopBarButton *button = [_arrayButtons objectAtIndex:index];
        if ([button isKindOfClass:[QiTopBarButton class]]) {
            return button;
        }
    }
    return nil;
}

- (void)setBackgroundImage:(UIImage *)image {
    
    _bacImgView.image = image;
}

- (void)setBackgroundImageHidden:(BOOL)isHidden {
    
    _bacImgView.hidden = isHidden;
}

- (void)setCursorColor:(UIColor *)color {
    
    _cursor.backgroundColor = color;
}

- (void)setCursorWidth:(CGFloat)width {
    
    _cursorWidth = width;
}

- (void)setCursorHeight:(CGFloat)height {
    
    _cursorHeight = height;
}

- (void)setTitleColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor {
    
    _normalColor = normalColor;
    _selectedColor = selectedColor;
}

- (void)setIsButtonAlignmentLeft:(BOOL)isAlignmentLeft {
    
    _isButtonAlignmentLeft = isAlignmentLeft;
}

- (void)setShowSeperateLines:(BOOL)showSeperateLines {
    
    _showSeperateLines = showSeperateLines;
}

- (void)setButtonMargin:(CGFloat)buttonMargin {
    
    _buttonMargin = buttonMargin;
}

@end
