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
#import "SqliteTool.h"
#import "displayModel.h"
#import "display_detail.h"
#import "locationPageViewController.h"
@interface firstViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIView *adView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *displayViewHeight;

@property (weak, nonatomic) IBOutlet UIView *displayView;
@property (weak, nonatomic) IBOutlet UIView *displayTopView;
@property (nonatomic,strong) NSArray * modelArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *displayHeight;
@property (nonatomic,weak) display_detail *referenceView;
@property (nonatomic,assign) CGFloat heightOfDisplay;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewHeight;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,assign) NSInteger num_load;
- (IBAction)btn_location;
//@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation firstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.num_load = 0;
    self.navigationController.navigationBar.hidden = YES;
    [self selectData];
    [self setScrollView];
}
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
    }
    return _bottomView;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    CGFloat a = point.y;
    if (a == self.bgViewHeight.constant) {
        [UIView animateWithDuration:2 animations:^{
            [self.bottomView removeFromSuperview];
        } completion:^(BOOL finished) {
            [self addOtherDisplayDetailView:self.num_load];
        }];
    }
    
    
}
- (void)addBottomView{
    self.bottomView.backgroundColor = [UIColor whiteColor];
    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    UIActivityIndicatorView *freshView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    freshView.center = CGPointMake(self.view.frame.size.width /2, 22);
    [_bottomView addSubview:freshView];
    [freshView startAnimating];
    
    [self.displayView addSubview:self.bottomView];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.displayView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.displayView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.referenceView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:44];
    [self.bottomView addConstraint:height];
    [self.displayView addConstraints:@[top,left,right]];
    
}
- (void)selectData{
    NSString *sql = @"select * from dataCell;";
    NSArray *arr = [SqliteTool selectWithSql:sql];
    _modelArray = arr;
//    for (displayModel *model in arr) {
//        NSLog(@"%@--%@--%@--%@--%d--%d",model.name,model.image,model.introdution,model.discount,model.price,model.sold);
//    }
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

- (void)setScrollView{
    self.scrollView.delegate = self;
    //self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width,2000);
    [self addBanner];
    [self addRefresh];
    [self addHomeMenu];
    [self addAd];
    [self addDispalyDetail];
    
    
}


- (void)addAd{
    adView *midAdView = [[adView alloc]initWithFrame:self.adView.bounds];
    [self.adView addSubview:midAdView];
}
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
    refresh.scrollview = self.scrollView;
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
}
- (void)addDispalyDetail{
    display_detail *view = [[NSBundle mainBundle]loadNibNamed:@"display_detail" owner:nil options:nil].firstObject;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.displayView addSubview:view];
    displayModel *datamodel = self.modelArray[0];
    view.model = datamodel;
    
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.displayView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.displayView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.displayTopView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:115];
    [view addConstraint:height];
    [self.displayView addConstraints:@[top,left,right]];
    self.referenceView = view;
    [self addOtherDisplayDetailView:self.num_load];
}
- (void)addOtherDisplayDetailView:(NSInteger)number{
    self.num_load += 1;

    for (int i=1; i<self.modelArray.count; i++) {
        display_detail *view = [[NSBundle mainBundle]loadNibNamed:@"display_detail" owner:nil options:nil].firstObject;
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self.displayView addSubview:view];
        displayModel *datamodel = self.modelArray[i];
        view.model = datamodel;
        if (view.lineNum > 1 && view.lineNum < 2) {
            self.heightOfDisplay = 115;
        }else{
            self.heightOfDisplay = 148;
        }
        //NSLog(@"%f",view.lineNum);
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.displayView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.displayView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.referenceView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.heightOfDisplay];
        [view addConstraint:height];
        [self.displayView addConstraints:@[top,left,right]];
        self.referenceView = view;

        self.displayHeight.constant = (44 + 115 * i)*self.num_load;
        self.bgViewHeight.constant = self.displayHeight.constant+150+44;
        //NSLog(@"%f", self.bgViewHeight.constant);

        //self.displayHeight.constant = 1000;
       // self.bgHeight.constant = view.frame.origin.y;
    }
    [self addBottomView];

    
    

}


- (IBAction)btn_location {
    locationPageViewController *locationVc = [[locationPageViewController alloc]init];
    [self presentViewController:locationVc animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
