//
//  display_detail.h
//  MeiTuan
//
//  Created by WangXinjia on 2018/3/15.
//  Copyright © 2018年 WangXinjia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "displayModel.h"

@interface display_detail : UIView
@property (weak, nonatomic) IBOutlet UILabel *lbl_introduction;
@property (weak, nonatomic) IBOutlet UILabel *lbl_name;
@property (weak, nonatomic) IBOutlet UIImageView *lbl_icon;
@property (weak, nonatomic) IBOutlet UILabel *lbl_price;
@property (weak, nonatomic) IBOutlet UILabel *lbl_sold;
@property (weak, nonatomic) IBOutlet UIButton *lbl_discount;

//@property (weak, nonatomic) IBOutlet UIImageView *botLine;
@property(nonatomic,strong)displayModel *model;

@end
