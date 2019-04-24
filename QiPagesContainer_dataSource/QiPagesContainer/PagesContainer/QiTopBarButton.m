//
//  IHStewardHeaderView.h
//  IoTHome
//
//  Created by wangdacheng on 2019/2/22.
//  Copyright © 2019 QiShare. All rights reserved.
//

#import "QiTopBarButton.h"

#define TitleFontSize (13)
#define ColorNormalDefault [UIColor blackColor]
#define ColorSelectedDefault [UIColor redColor];

@interface QiTopBarButton()

@end

@implementation QiTopBarButton

- (instancetype)init {
    
    self = [super init];
    if (self) {
        _normalColor = ColorNormalDefault;
        _selectedColor = ColorSelectedDefault;
        [self setTitleColor:_normalColor forState:UIControlStateNormal];
        [self setTitleColor:_selectedColor forState:UIControlStateSelected];
        
        [self.titleLabel setFont:[UIFont systemFontOfSize:TitleFontSize]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    
    [super setSelected:selected];
    if (selected) {
        [self setTitleColor:_selectedColor forState:UIControlStateNormal];
        UIFont *font = [UIFont systemFontOfSize:TitleFontSize + 1 weight:UIFontWeightBold];
        [self.titleLabel setFont:font];
    } else {
        [self setTitleColor:_normalColor forState:UIControlStateNormal];
        UIFont *font = [UIFont systemFontOfSize:TitleFontSize weight:normal];
        [self.titleLabel setFont:font];
    }
}

@end
