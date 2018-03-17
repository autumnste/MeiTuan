//
//  displayModel.m
//  MeiTuan
//
//  Created by WangXinjia on 2018/3/15.
//  Copyright © 2018年 WangXinjia. All rights reserved.
//

#import "displayModel.h"

@implementation displayModel
+ (instancetype)displayWithName: (NSString *)name image: (NSString *)image introduction: (NSString *)introduction discount: (NSString *)discount price:(int)price sold: (int)sold
{
    displayModel *model = [[self alloc] init];
    model.name = name;
    model.image = image;
    model.introdution = introduction;
    model.discount = discount;
    model.price = price;
    model.sold = sold;
    return model;
}
@end
