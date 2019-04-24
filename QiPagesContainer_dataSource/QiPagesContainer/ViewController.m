//
//  ViewController.m
//  QiPagesContainer
//
//  Created by wangdacheng on 2019/3/4.
//  Copyright © 2019 dac_1033. All rights reserved.
//

#import "ViewController.h"
#import "QiPagesContainer.h"

@interface ViewController () <QiPagesContainerDelegate, QiPagesContainerDataSource>

@property (nonatomic, strong) QiPagesContainer *pageContainer;

@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *viewArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"QiPagesContainer"];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self setupViews];
    [self setupNavBarBtn];
}

- (void)setupNavBarBtn {
    
    UIBarButtonItem *rBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"右击" style:UIBarButtonItemStylePlain target:self action:@selector(rBarBtnClicked)];
    [self.navigationItem setRightBarButtonItem:rBarBtn];
}

- (void) setupViews {
    
    CGFloat margin = 0;
    CGSize size = self.view.frame.size;
    
    _titleArr = [NSArray arrayWithObjects:@"我的设备我的设备", @"卧室", @"厨房厨房厨房厨房", @"门厅", nil];
    
    _pageContainer = [[QiPagesContainer alloc] initWithFrame:CGRectMake(margin, 0, size.width - margin * 2, size.height)];
    _pageContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_pageContainer setBackgroundColor:[UIColor lightGrayColor]];
    _pageContainer.delegate = self;
    _pageContainer.dataSource = self;
    [_pageContainer setIsButtonAlignmentLeft:YES];
    [_pageContainer setCursorHeight:3.0];
    [_pageContainer setCursorColor:[UIColor whiteColor]];
    [_pageContainer setTitleColor:[UIColor whiteColor] selectedColor:[UIColor whiteColor]];
    
    NSMutableArray *tempTableViews = [NSMutableArray array];
    for (int i=0; i<[_titleArr count]; i++) {
        UIColor *randomColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:0.3];
        UIView *subView = [[UIView alloc] initWithFrame:CGRectZero];
        subView.backgroundColor = randomColor;
        [tempTableViews addObject:subView];
    }
    _viewArr = [NSArray arrayWithArray:tempTableViews];
    
    [self.view addSubview:_pageContainer];
}


#pragma mark - IHPagesContainerDelegate
- (NSInteger)numberPageContainder:(QiPagesContainer *)pagesContainer {
    
    return _titleArr.count;
}

- (NSString *)pageContainder:(QiPagesContainer *)pagesContainer titleForRowAtIndex:(NSInteger)index {
    
    return [_titleArr objectAtIndex:index];
}

- (UIView *)pageContainder:(QiPagesContainer *)pagesContainer viewForRowAtIndex:(NSInteger)index {
    
    return [_viewArr objectAtIndex:index];
}




- (void)pageContainder:(QiPagesContainer *)container selectIndex:(NSInteger)index {
    
}


- (void)onClickPageIndicator:(QiPagesContainer *)container selectIndex:(NSInteger)index {
    
}


#pragma mark - Actions

- (void)rBarBtnClicked {
    
    CGSize size = self.view.frame.size;
    UIView *topBar = (UIView *)[_pageContainer topBar];
    
    _titleArr = [NSArray arrayWithObjects:@"001", @"0002", @"000004", @"0005",  @"0006", @"0007", nil];
    NSMutableArray *tempTableViews = [NSMutableArray array];
    for (int i=0; i<[_titleArr count]; i++) {
        UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height - topBar.frame.size.height)];
        subView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:0.3];
        [tempTableViews addObject:subView];
    }
    _viewArr = [NSArray arrayWithArray:tempTableViews];
    
    [_pageContainer reloadData];
}



@end
