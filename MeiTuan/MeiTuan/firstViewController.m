//
//  firstViewController.m
//  MeiTuan
//
//  Created by WangXinjia on 2018/3/6.
//  Copyright © 2018年 WangXinjia. All rights reserved.
//

#import "firstViewController.h"
#import "SQBannarView.h"
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
- (void)setScrollView{
    self.scrollView.contentSize = self.view.bounds.size;
}
- (void)addBanner{
    NSMutableArray *imageViews = @[].mutableCopy;
    for (NSInteger i=0; i<5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"banner_%ld.png",i+1]];
        [imageViews addObject:image];
    }
    
    SQBannarView *bannerView = [[SQBannarView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 150) viewSize:CGSizeMake(CGRectGetWidth(self.scrollView.bounds),100)];
    bannerView.items = imageViews;
    [self.scrollView addSubview:bannerView];
    
    [bannerView imageViewClick:^(SQBannarView * _Nonnull barnerview, NSInteger index) {
        NSLog(@"点击图片%ld",index);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
