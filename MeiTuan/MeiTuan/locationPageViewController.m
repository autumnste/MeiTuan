//
//  locationPageViewController.m
//  MeiTuan
//
//  Created by WangXinjia on 2018/3/21.
//  Copyright © 2018年 WangXinjia. All rights reserved.
//

#import "locationPageViewController.h"
#import "ContentViewController.h"
@interface locationPageViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSArray *pageContentArray;
@property(nonatomic,assign)int index;


@end

@implementation locationPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置UIPageViewController的配置项
    NSDictionary *options = @{UIPageViewControllerOptionInterPageSpacingKey : @(0)};
    
    // 根据给定的属性实例化UIPageViewController
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                        options:options];
    // 设置UIPageViewController代理和数据源
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    
    // 设置UIPageViewController初始化数据, 将数据放在NSArray里面
    // 如果 options 设置了 UIPageViewControllerSpineLocationMid,注意viewControllers至少包含两个数据,且 doubleSided = YES
    
    ContentViewController *initialViewController = [self viewControllerAtIndex:0];// 得到第一页
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [_pageViewController setViewControllers:viewControllers
                                  direction:UIPageViewControllerNavigationDirectionReverse
                                   animated:NO
                                 completion:nil];
    
    // 设置UIPageViewController 尺寸
    _pageViewController.view.frame = self.view.bounds;
    // 在页面上，显示UIPageViewController对象的View
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self addTopView];
}

- (void)addTopView{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 63, self.view.frame.size.width, 1)];
    line.backgroundColor = [UIColor grayColor];
    UIButton *btnBack = [[UIButton alloc]initWithFrame:CGRectMake(10, 26, 50, 22)];
    [btnBack setTitle:@"取消" forState:UIControlStateNormal];
    [btnBack.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [btnBack setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btnBack.contentHorizontalAlignment = UIStackViewAlignmentLeading;
    btnBack.contentVerticalAlignment = UIStackViewAlignmentCenter;
    [btnBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    [topView addSubview:line];
    [topView addSubview:btnBack];
    UIView *btnView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 30)];
    btnView.backgroundColor = [UIColor whiteColor];
    UIButton *btnLocation = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2, 30)];
    [btnLocation setTitle:@"国内" forState:UIControlStateNormal];
    [btnLocation addTarget:self action:@selector(jumpToFirst) forControlEvents:UIControlEventTouchUpInside];
    [btnLocation setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    UIButton *btnInternation = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, 0, self.view.frame.size.width/2, 30)];
    [btnInternation setTitle:@"国际/港澳台" forState:UIControlStateNormal];
    [btnInternation addTarget:self action:@selector(jumpToSecond) forControlEvents:UIControlEventTouchUpInside];
    [btnInternation setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

    [self.view addSubview:btnView];
    [btnView addSubview:btnLocation];
    [btnView addSubview:btnInternation];
    

}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (NSArray *)pageContentArray {
    if (!_pageContentArray) {
        NSMutableArray *arrayM = [[NSMutableArray alloc] init];
        for (int i = 1; i < 3; i++) {
            NSString *contentString = [[NSString alloc] initWithFormat:@"page NO.%d", i];
            [arrayM addObject:contentString];
        }
        _pageContentArray = [[NSArray alloc] initWithArray:arrayM];
        
    }
    return _pageContentArray;
}

#pragma mark - UIPageViewControllerDataSource And UIPageViewControllerDelegate

#pragma mark 返回上一个ViewController对象

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:(ContentViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    // 返回的ViewController，将被添加到相应的UIPageViewController对象上。
    // UIPageViewController对象会根据UIPageViewControllerDataSource协议方法,自动来维护次序
    // 不用我们去操心每个ViewController的顺序问题
    return [self viewControllerAtIndex:index];
    
    
}

#pragma mark 返回下一个ViewController对象

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:(ContentViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.pageContentArray count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
    
    
}

- (void)jumpToFirst{
    if (!(self.index == 0)) {
        ContentViewController *contentVC = [self viewControllerAtIndex:0];
        
        [self.pageViewController setViewControllers:[NSArray arrayWithObject:contentVC] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    }
}
- (void)jumpToSecond{
    if (!(self.index == 1)) {
        ContentViewController *contentVC = [self viewControllerAtIndex:1];
        
        [self.pageViewController setViewControllers:[NSArray arrayWithObject:contentVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
}
#pragma mark - 根据index得到对应的UIViewController

- (ContentViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (([self.pageContentArray count] == 0) || (index >= [self.pageContentArray count])) {
        return nil;
    }
    // 创建一个新的控制器类，并且分配给相应的数据
    ContentViewController *contentVC = [[ContentViewController alloc] init];
    contentVC.content = [self.pageContentArray objectAtIndex:index];
    
    return contentVC;
}

#pragma mark - 数组元素值，得到下标值

- (NSUInteger)indexOfViewController:(ContentViewController *)viewController {
    self.index = (int)[self.pageContentArray indexOfObject:viewController.content];
    return [self.pageContentArray indexOfObject:viewController.content];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
