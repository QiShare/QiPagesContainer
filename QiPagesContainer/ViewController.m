//
//  ViewController.m
//  QiPagesContainer
//
//  Created by wangdacheng on 2019/3/4.
//  Copyright © 2019 dac_1033. All rights reserved.
//

#import "ViewController.h"
#import "QiPagesContainer.h"

@interface ViewController () <QiPagesContainerDelegate>

@property (nonatomic, strong) QiPagesContainer *pageContainer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"QiPagesContainer"];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self setupViews];
}

- (void) setupViews {
    
    CGFloat margin = 0;
    CGSize size = self.view.frame.size;
    
    NSArray *titles = [NSArray arrayWithObjects:@"我的设备", @"卧室", @"厨房厨房厨房厨房", @"门厅", nil];
    NSMutableArray *tempTableViews = [NSMutableArray array];
    _pageContainer = [[QiPagesContainer alloc] initWithFrame:CGRectMake(margin, 0, size.width - margin * 2, size.height)];
    _pageContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_pageContainer setBackgroundColor:[UIColor lightGrayColor]];
    _pageContainer.delegate = self;
    [_pageContainer updateContentWithTitles:titles];
    [_pageContainer setIsButtonAlignmentLeft:YES];
    [_pageContainer setCursorHeight:3.0];
    [_pageContainer setCursorColor:[UIColor whiteColor]];
    [_pageContainer setTextColor:[UIColor whiteColor] andSelectedColor:[UIColor whiteColor]];
    
    UIView *topBar = (UIView *)[_pageContainer topBar];
    for (int i=0; i<[titles count]; i++) {
        UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height - topBar.frame.size.height)];
        subView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:0.3];
        [tempTableViews addObject:subView];
    }
    [_pageContainer updateContentWithViews:tempTableViews];
    
    [self.view addSubview:_pageContainer];
}


#pragma mark - IHPagesContainerDelegate

- (void)pageContainder:(QiPagesContainer *)container selectIndex:(NSInteger)index {
    
}


- (void)onClickPageIndicator:(QiPagesContainer *)container selectIndex:(NSInteger)index {
    
}

@end
