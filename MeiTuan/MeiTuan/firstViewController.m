//
//  firstViewController.m
//  MeiTuan
//
//  Created by WangXinjia on 2018/3/6.
//  Copyright © 2018年 WangXinjia. All rights reserved.
//

#import "firstViewController.h"

@interface firstViewController ()
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

@end

@implementation firstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
