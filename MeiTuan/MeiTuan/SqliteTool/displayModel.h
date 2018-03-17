//
//  displayModel.h
//  MeiTuan
//
//  Created by WangXinjia on 2018/3/15.
//  Copyright © 2018年 WangXinjia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface displayModel : NSObject
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * image;
@property(nonatomic,copy)NSString * introdution;
@property(nonatomic,copy)NSString * discount;
@property(nonatomic,assign)int sold;
@property(nonatomic,assign)int price;

+ (instancetype)displayWithName: (NSString *)name image: (NSString *)image introduction: (NSString *)introduction discount: (NSString *)discount price:(int)price sold: (int)sold;
@end
