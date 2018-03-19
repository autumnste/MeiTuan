//
//  display_detail.m
//  MeiTuan
//
//  Created by WangXinjia on 2018/3/15.
//  Copyright © 2018年 WangXinjia. All rights reserved.
//

#import "display_detail.h"
@interface display_detail()
@end
@implementation display_detail



//- (instancetype)init{
//    self = [super init];
//    if (self) {
//        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"display_detail" owner:nil options:nil];
//        UIView *view = [array objectAtIndex:0];
//    
//        [self addSubview:view];
//    }
//
//    return self;
//}
- (void)setModel:(displayModel *)model{
    _model = model;
    self.lbl_introduction.text = model.introdution;
    self.lbl_name.text = model.name;
    [self.lbl_discount setTitle:model.discount forState:UIControlStateNormal];
    NSString *icon = model.image;
    self.lbl_icon.image = [UIImage imageNamed:icon];
    self.lbl_price.text = [NSString stringWithFormat:@"¥ %d",model.price];
    self.lbl_sold.text = [NSString stringWithFormat:@"已售 %d",model.sold];
    CGFloat labelHeight = [self.lbl_introduction sizeThatFits:CGSizeMake(self.lbl_introduction.frame.size.width, MAXFLOAT)].height;
    NSNumber *count = @((labelHeight) / self.lbl_introduction.font.lineHeight);
    CGFloat line =  [count floatValue];
    self.lineNum = line;
    int w =  (int)self.lbl_discount.titleLabel.text.description.length;
    self.discountWidth.constant = w*13+15;
    [self.lbl_discount.layer setBorderColor:[UIColor redColor].CGColor];
    [self.lbl_discount.layer setBorderWidth:1];
    [self.lbl_discount.layer setMasksToBounds:YES];
    [self.lbl_discount.layer setCornerRadius:3.0];
    //NSLog(@"%d",w);
}


@end
