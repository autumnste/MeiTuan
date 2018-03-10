//
//  profileSettingViewController.m
//  MeiTuan
//
//  Created by WangXinjia on 2018/3/9.
//  Copyright © 2018年 WangXinjia. All rights reserved.
//

#import "profileSettingViewController.h"


@interface profileSettingViewController ()

@end

@implementation profileSettingViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"个人信息";
    self.navigationItem.leftBarButtonItem = [self setBackItem];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIBarButtonItem *)setBackItem{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 25)];
    UIButton *btn = [[UIButton alloc]initWithFrame:view.frame];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"btn_backItem.png"] forState:UIControlStateNormal];
    [view addSubview:btn];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithCustomView:view];
    return backBtn;
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
