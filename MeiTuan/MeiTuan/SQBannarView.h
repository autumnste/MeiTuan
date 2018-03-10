//
//  SQBannarView.h
//  SQBannerView
//
//  Created by yangsq on 2017/5/17.
//  Copyright © 2017年 yangsq. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface SQBannarView : UIView

- (id)initWithFrame:(CGRect)frame viewSize:(CGSize)viewSize;

@property (strong, nonatomic) NSArray *items;


@property (copy, nonatomic) void(^imageViewClick)(SQBannarView *barnerview,NSInteger index);
//点击图片
- (void)imageViewClick:(void(^)(SQBannarView *barnerview,NSInteger index))block;


NS_ASSUME_NONNULL_END

@end
