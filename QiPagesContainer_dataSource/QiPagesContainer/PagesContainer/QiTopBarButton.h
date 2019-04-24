//
//  IHStewardHeaderView.h
//  IoTHome
//
//  Created by wangdacheng on 2019/2/22.
//  Copyright © 2019 QiShare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QiTopBarButton : UIButton

@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, copy)  NSString* imgIndicatorName;

@end

