//
//  mineAllMenu.m
//  MeiTuan
//
//  Created by WangXinjia on 2018/3/9.
//  Copyright © 2018年 WangXinjia. All rights reserved.
//

#import "mineAllMenu.h"

@implementation mineAllMenu

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.autoresizesSubviews = NO;

    if (self) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"mineAllMenu" owner:self options:nil];
        UIView *view = [array objectAtIndex:0];
        view.frame = frame;
        [self addSubview:view];
    }
    
    return self;
}

- (IBAction)pushToCollection:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"CollectionClick" object:nil];

}
@end
