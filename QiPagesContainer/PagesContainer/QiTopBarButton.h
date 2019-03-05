//
//  IHStewardHeaderView.h
//  IoTHome
//
//  Created by wangdacheng on 2019/2/22.
//  Copyright © 2019 QiShare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QiTopBarButton : UIButton

@property (nonatomic, strong) UIColor *colorNormal;
@property (nonatomic, strong) UIColor *colorSelected;
@property (nonatomic, copy)  NSString* imgIndicatorName;

// 角标 (左上角位置 文字为白色背景为红色)
- (void)setBadgeStr:(NSString *)badgeStr;

// 隐藏角标
- (void)hideBadge;

@end

