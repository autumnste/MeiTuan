//
//  profileView.h
//  MeiTuan
//
//  Created by WangXinjia on 2018/3/7.
//  Copyright © 2018年 WangXinjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface profileView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
- (IBAction)headImageClick;

@property (weak, nonatomic) IBOutlet UILabel *userName;
@end
