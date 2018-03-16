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
#import "adView.h"
#import "BGRefresh.h"
#import "locationViewController.h"
#import <sqlite3.h>
#import "Cell.h"
@interface firstViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UIView *adView;
@property (weak, nonatomic) IBOutlet UIView *cellView;

@property (weak, nonatomic) IBOutlet UIView *menuView;
- (IBAction)btn_location;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation firstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.navigationController.navigationBar.hidden = YES;
    [self setTablelView];
    
    
}

- (UIView *)bannerView{
    if (_bannerView == nil) {
        NSMutableArray *imageViews = @[].mutableCopy;
        for (NSInteger i=0; i<5; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"banner_%ld.png",i+1]];
            [imageViews addObject:image];
        }
        SQBannarView *bannerView = [[SQBannarView alloc]initWithFrame:self.bannerView.frame viewSize:self.bannerView.frame.size];
        bannerView.items = imageViews;
        
        [bannerView imageViewClick:^(SQBannarView * _Nonnull barnerview, NSInteger index) {
            NSLog(@"点击图片%ld",index + 1);
        }];
        _bannerView = bannerView;
    }
    return _bannerView;
}
- (void)addHomeMenu{
    homePageMenu *homeMenu = [[homePageMenu alloc]initWithFrame:self.menuView.bounds];
    [_menuView addSubview:homeMenu];
}

- (void)setTablelView{
    self.tableView.delegate = self;
    [self addBanner];
    [self addRefresh];
    [self addHomeMenu];
    [self addAd];
    //[self addcell];
}

- (void)addAd{
    adView *midAdView = [[adView alloc]initWithFrame:self.adView.bounds];
    [self.adView addSubview:midAdView];
}
//- (void)addcell{
//    Cell *cell = [[NSBundle mainBundle]loadNibNamed:@"Cell" owner:nil options:nil].firstObject;
//    [self.cellView addSubview:cell];
//}
- (void)addRefresh{
    BGRefresh *refresh = [[BGRefresh alloc] init];
    refresh.startBlock = ^{
        NSLog(@"开始刷新....");
    };
    refresh.endBlock = ^{
        NSLog(@"结束刷新....");
    };
    refresh.isAutoEnd = YES;//设为自动结束刷新 YES/NO 自动/手动
    refresh.refreshTime = 1.0;//设置自动刷新时间(秒为单位) 手动结束刷新时不设置此项
    refresh.scrollview = self.tableView;
}
- (void)addBanner{
    NSMutableArray *imageViews = @[].mutableCopy;
    for (NSInteger i=0; i<5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"banner_%ld.png",i+1]];
        [imageViews addObject:image];
    }
    SQBannarView *bannerView = [[SQBannarView alloc]initWithFrame:self.bannerView.bounds viewSize:self.bannerView.bounds.size];
    bannerView.items = imageViews;
    [bannerView imageViewClick:^(SQBannarView * _Nonnull barnerview, NSInteger index) {
        NSLog(@"点击图片%ld",index + 1);
    }];
    [_bannerView addSubview:bannerView];
   // NSLog(@"1");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"displayCell"];
    return cell;
}

- (IBAction)btn_location {
    locationViewController *locationVc = [[locationViewController alloc]init];
    [self presentViewController:locationVc animated:YES completion:nil];
}
@end
