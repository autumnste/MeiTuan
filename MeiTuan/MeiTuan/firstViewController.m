//
//  firstViewController.m
//  MeiTuan
//
//  Created by WangXinjia on 2018/3/6.
//  Copyright © 2018年 WangXinjia. All rights reserved.
//

#import "firstViewController.h"
#import "SQBannarView.h"
#import "homePageMenu.h"
#import "BGRefresh.h"
@interface firstViewController ()
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation firstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [self setScrollView];
    [self addBanner];
    
}
- (void)addHomeMenuWithFrame: (CGRect)frame{
    homePageMenu *homeMenu = [[homePageMenu alloc]initWithFrame:frame];
    [self.scrollView addSubview:homeMenu];
   
}
- (void)setScrollView{
    self.scrollView.contentSize = self.view.bounds.size;
    [self addRefresh];
}
- (void)addRefresh{
    BGRefresh* refresh = [[BGRefresh alloc] init];
    refresh.startBlock = ^{
        NSLog(@"开始刷新....");
    };
    refresh.endBlock = ^{
        NSLog(@"结束刷新....");
    };
    refresh.isAutoEnd = YES;//设为自动结束刷新 YES/NO 自动/手动
    refresh.refreshTime = 1.0;//设置自动刷新时间(秒为单位) 手动结束刷新时不设置此项
    refresh.scrollview = self.scrollView;
}
- (void)addBanner{
    NSMutableArray *imageViews = @[].mutableCopy;
    for (NSInteger i=0; i<5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"banner_%ld.png",i+1]];
        [imageViews addObject:image];
    }
    SQBannarView *bannerView = [[SQBannarView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 50) viewSize:CGSizeMake(CGRectGetWidth(self.scrollView.bounds),100)];
    bannerView.items = imageViews;
    [self.scrollView addSubview:bannerView];
    
    [bannerView imageViewClick:^(SQBannarView * _Nonnull barnerview, NSInteger index) {
        NSLog(@"点击图片%ld",index + 1);
    }];
    //banner下面addMenu
    [self addHomeMenuWithFrame:CGRectMake(0, CGRectGetMaxY(bannerView.bounds), self.scrollView.frame.size.width, 200)];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
