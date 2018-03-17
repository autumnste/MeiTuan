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
    self.lbl_discount.titleLabel.text = model.discount;
    NSString *icon = model.image;
    self.lbl_icon.image = [UIImage imageNamed:icon];
    self.lbl_price.text = [NSString stringWithFormat:@"¥ %d",model.price];
    self.lbl_sold.text = [NSString stringWithFormat:@"已售 %d",model.sold];

}


@end
