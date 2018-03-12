//
//  homePageMenu.m
//  MeiTuan
//
//  Created by WangXinjia on 2018/3/11.
//  Copyright © 2018年 WangXinjia. All rights reserved.
//

#import "homePageMenu.h"

@implementation homePageMenu
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.autoresizesSubviews = NO;

    if (self) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"homePageMenu" owner:self options:nil];
        UIView *view = [array objectAtIndex:0];
        view.frame = frame;
        [self addSubview:view];
    }
    
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
