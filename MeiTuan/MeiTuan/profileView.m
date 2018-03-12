//
//  profileView.m
//  MeiTuan
//
//  Created by WangXinjia on 2018/3/7.
//  Copyright © 2018年 WangXinjia. All rights reserved.
//

#import "profileView.h"
#import "mineViewController.h"

@implementation profileView



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.autoresizesSubviews = NO;
    if (self) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"profileView" owner:self options:nil];
        UIView *view = [array objectAtIndex:0];
        view.frame = frame;
        [self addSubview:view];
    }
    
    return self;
}

- (IBAction)headImageClick{
   [[NSNotificationCenter defaultCenter]postNotificationName:@"headDidClick" object:nil];
}
@end
