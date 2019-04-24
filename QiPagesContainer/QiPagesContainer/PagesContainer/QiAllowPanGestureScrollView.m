//
//  IHStewardHeaderView.h
//  IoTHome
//
//  Created by wangdacheng on 2019/2/22.
//  Copyright © 2019 QiShare. All rights reserved.
//

#import "QiAllowPanGestureScrollView.h"

@implementation QiAllowPanGestureScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] &&
        [otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        
        return YES;
    } else {
        return  NO;
    }
}

@end
