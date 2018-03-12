//
//  mineViewController.m
//  MeiTuan
//
//  Created by WangXinjia on 2018/3/7.
//  Copyright © 2018年 WangXinjia. All rights reserved.
//

#import "mineViewController.h"
#import "profileView.h"
#import "profileSettingViewController.h"
#import "mineAllMenu.h"
#import "Conllection.h"
@interface mineViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property(nonatomic,assign)float fresh;
@property(nonatomic,weak)UIView *topView;
@end

@implementation mineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.autoresizesSubviews = NO;

    self.navigationController.navigationBar.hidden = YES;
    UIView *topview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    topview.backgroundColor = [UIColor colorWithRed:37.0/255.0 green:186.0/255.0 blue:173.0/255.0 alpha:1];
    self.fresh = 0;
    topview.alpha = self.fresh;
    
    self.topView = topview;
    [self.view addSubview:self.topView];
    [self topButtonsWithTopView:self.topView.frame];
    [self setScrollView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushProfileSetting) name:@"headDidClick" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushCollection) name:@"CollectionClick" object:nil];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;

}
- (void)topButtonsWithTopView: (CGRect)topframe{
    UIView *clearview = [[UIView alloc]initWithFrame:topframe];
    clearview.backgroundColor = [UIColor clearColor];
    UIButton *btnSet = [[UIButton alloc]init];
    [btnSet setImage:[UIImage imageNamed:@"icon_main_setting.png"] forState:UIControlStateNormal];
    btnSet.frame = CGRectMake(10, (topframe.size.height - 20) * 0.6, 20, 20);
    
    UIButton *btnMsg = [[UIButton alloc]init];
    [btnMsg setImage:[UIImage imageNamed:@"icon_navigationItem_message_normal.png"] forState:UIControlStateNormal];
    btnMsg.frame =CGRectMake(topframe.size.width - 30, btnSet.frame.origin.y, 20, 20);
    
    UIButton *btnTheme = [[UIButton alloc]init];
    [btnTheme setImage:[UIImage imageNamed:@"icon_navigationItem_theme_normal.png"] forState:UIControlStateNormal];
    btnTheme.frame = CGRectMake(btnMsg.frame.origin.x - 30, btnSet.frame.origin.y, 20, 20);
    [clearview addSubview:btnMsg];
    [clearview addSubview:btnTheme];
    [clearview addSubview:btnSet];
    [self.view addSubview:clearview];
}

- (void)setScrollView{
    CGSize size = {self.view.bounds.size.width,self.view.bounds.size.height};
    self.scrollView.contentSize = size;
    self.scrollView.delegate = self;
    UIView *bgWhite = [[UIView alloc]init];
    bgWhite.backgroundColor = [UIColor whiteColor];
    UIImage *arc = [UIImage imageNamed:@"mineTopArc.png"];
    bgWhite.frame = CGRectMake(0, 124, self.view.frame.size.width, self.scrollView.frame.size.height+200);
    UIImageView *arcimg = [[UIImageView alloc]initWithImage:arc];
    arcimg.frame = CGRectMake(0, 64, self.view.bounds.size.width, 60);
    profileView *head = [[profileView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-200)/4, 40, 200, 100)];
    mineAllMenu *menu = [[mineAllMenu alloc]initWithFrame:CGRectMake(0, head.frame.size.height + 10, self.view.frame.size.width,270)];
    [self.scrollView addSubview:bgWhite];
    [self.scrollView addSubview:head];
    [self.scrollView addSubview:menu];
    [self.scrollView addSubview:arcimg];
    [self.scrollView bringSubviewToFront:head];

    
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
- (void)pushCollection{
    Conllection *collection = [[Conllection alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:collection animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
- (void)pushProfileSetting{
    profileSettingViewController *profileSetting = [[profileSettingViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:profileSetting animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
- (void)dealloc{
    NSLog(@"已注销");
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
