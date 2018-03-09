//
//  mineViewController.m
//  MeiTuan
//
//  Created by WangXinjia on 2018/3/7.
//  Copyright © 2018年 WangXinjia. All rights reserved.
//

#import "mineViewController.h"
#import "profileView.h"
@interface mineViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property(nonatomic,assign)float fresh;
@property(nonatomic,weak)UIView *topView;
@end

@implementation mineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    UIView *topview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    topview.backgroundColor = [UIColor colorWithRed:37.0/255.0 green:186.0/255.0 blue:173.0/255.0 alpha:1];
    self.fresh = 0;
    topview.alpha = self.fresh;
    self.topView = topview;
    [self.view addSubview:self.topView];
    [self setScrollView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushProfileSetting) name:@"headDidClick" object:nil];
}

- (void)setScrollView{
    CGSize size = {self.view.bounds.size.width,self.view.bounds.size.height + 50};
    self.scrollView.contentSize = size;
    self.scrollView.delegate = self;
    UIView *bgWhite = [[UIView alloc]init];
    bgWhite.backgroundColor = [UIColor whiteColor];
    UIImage *arc = [UIImage imageNamed:@"mineTopArc.png"];
    bgWhite.frame = CGRectMake(0, 124, self.scrollView.frame.size.width, self.scrollView.contentSize.height);
    UIImageView *arcimg = [[UIImageView alloc]initWithImage:arc];
    arcimg.frame = CGRectMake(0, 64, self.scrollView.bounds.size.width, 60);
    profileView *head = [[profileView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-200)/4, 40, 200, 100)];
    [self.scrollView addSubview:head];
    [self.scrollView addSubview:arcimg];
    [self.scrollView addSubview:bgWhite];
    [self.scrollView bringSubviewToFront:head];

    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

}

/**
 

 @param scrollView 监控拖动代理方法
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    CGFloat a = point.y;
    CGFloat x = a+20;
    CGFloat rat = x / 144;
    if (rat > 1) {
        self.fresh = 1;
    }else if (rat < 0){
        self.fresh = 0;
    }else{
        self.fresh = rat;
    }
   // NSLog(@"---%.1f",x / 144);
    [UIView animateWithDuration:0 animations:^{
        [self.topView setAlpha:rat];
    }];
//    NSLog(@"%f",self.topView.alpha);
//    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)pushProfileSetting{
    [self.navigationController pushViewController:<#(nonnull UIViewController *)#> animated:YES];
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
