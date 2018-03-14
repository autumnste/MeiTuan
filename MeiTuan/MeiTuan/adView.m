//
//  adView.m
//  MeiTuan
//
//  Created by WangXinjia on 2018/3/12.
//  Copyright © 2018年 WangXinjia. All rights reserved.
//

#import "adView.h"

@implementation adView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"adView" owner:self options:nil];
        UIView *view = [array objectAtIndex:0];
        view.frame = frame;
        [self addSubview:view];
    }
    
    return self;
}

@end
