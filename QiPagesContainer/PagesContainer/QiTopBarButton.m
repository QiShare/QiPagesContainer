//
//  IHStewardHeaderView.h
//  IoTHome
//
//  Created by wangdacheng on 2019/2/22.
//  Copyright © 2019 QiShare. All rights reserved.
//

#import "QiTopBarButton.h"

#define BADGE_WIDTH (13)
#define TitleFontSize (13)
#define ColorNormalDefault [UIColor blackColor]
#define ColorSelectedDefault [UIColor redColor];

@interface QiTopBarButton()

@end

@implementation QiTopBarButton

- (id)init {
    
    self = [super init];
    if (self) {
        _colorNormal = ColorNormalDefault;
        _colorSelected = ColorSelectedDefault;
        [self setTitleColor:_colorSelected forState:UIControlStateSelected];
        [self setTitleColor:_colorNormal forState:UIControlStateNormal];
        
        [self.titleLabel setFont:[UIFont systemFontOfSize:TitleFontSize]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    
    [super setSelected:selected];
    if (selected) {
        [self setTitleColor:_colorSelected forState:UIControlStateNormal];
        UIFont *font = [UIFont systemFontOfSize:TitleFontSize + 1 weight:UIFontWeightBold];
        [self.titleLabel setFont:font];
    } else {
        [self setTitleColor:_colorNormal forState:UIControlStateNormal];
        UIFont *font = [UIFont systemFontOfSize:TitleFontSize weight:normal];
        [self.titleLabel setFont:font];
    }
}

@end
