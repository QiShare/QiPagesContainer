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

@property (nonatomic, strong) UILabel *labelBadge;
@property (nonatomic, strong) UIImageView *viewBadge;
@property (nonatomic, strong) UIImageView *imgIndicator;

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
        
        _viewBadge = [[UIImageView alloc] init];
        [_viewBadge setUserInteractionEnabled:NO];
        [self addSubview:_viewBadge];
        
        _labelBadge = [[UILabel alloc] initWithFrame:CGRectZero];
        [_labelBadge setBackgroundColor:[UIColor clearColor]];
        [_labelBadge setTextColor:[UIColor whiteColor]];
        [_labelBadge setTextAlignment:NSTextAlignmentCenter];
        [_labelBadge setFont:[UIFont systemFontOfSize:10]];
        [_viewBadge addSubview:_labelBadge];
        
        _imgIndicator = [[UIImageView alloc]init];
        _imgIndicator.hidden = YES;
        [self addSubview:_imgIndicator];
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

- (void)setBadgeStr:(NSString *)badgeStr {
    
    if (badgeStr == nil) {
        [self hideBadge];
        return;
    }
    _viewBadge.hidden = NO;
    
    CGSize size = self.frame.size;
    NSDictionary *attribute = @{NSFontAttributeName:self.titleLabel.font};
    CGSize sizeText = [self.titleLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    CGFloat xPos = size.width - (size.width - sizeText.width) / 2;
    CGFloat yPos = self.frame.size.height/2 - BADGE_WIDTH;
    
    _labelBadge.text = badgeStr;
    [_labelBadge sizeToFit];
    CGRect frame = _labelBadge.frame;
    frame.origin.x = xPos;
    frame.origin.y = yPos;
    frame.size.width = frame.size.width + 6;
    frame.size.height = BADGE_WIDTH;
    if (frame.size.width < BADGE_WIDTH) {
        frame.size.width = BADGE_WIDTH;
    }
    if (frame.origin.x+frame.size.width > size.width) {
        frame.origin.x = size.width - frame.size.width;
    }
    _viewBadge.frame = frame;
    _labelBadge.frame = CGRectMake(0, -.5, CGRectGetWidth(_viewBadge.frame), CGRectGetHeight(_viewBadge.frame));
}

- (void)hideBadge {
    
    _viewBadge.hidden = YES;
}

- (void)setImgIndicatorName:(NSString *)imgIndicatorName{
    
    _imgIndicatorName = imgIndicatorName;
    _imgIndicator.hidden = NO;
    UIImage *img = [UIImage imageNamed:imgIndicatorName];
    [_imgIndicator setImage:img];
}

@end
