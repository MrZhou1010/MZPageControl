//
//  ViewController.m
//  MZPageControl
//
//  Created by 木木 on 2019/11/18.
//  Copyright © 2019 Mr.Z. All rights reserved.
//

#import "ViewController.h"
#import "MZPageControl.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *demo1View = [[UIView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 30)];
    demo1View.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:demo1View];
    UILabel *demo1Lbl = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 50, 30)];
    demo1Lbl.text = @"默认:";
    [demo1View addSubview:demo1Lbl];
    MZPageControl *demo1PageControl = [[MZPageControl alloc] initWithFrame:CGRectMake(66, 0, 300, 30)];
    demo1PageControl.numberOfPages = 5;
    demo1PageControl.currentPage = 0;
    [demo1View addSubview:demo1PageControl];
    
    UIView *demo2View = [[UIView alloc] initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, 30)];
    demo2View.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:demo2View];
    UILabel *demo2Lbl = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 50, 30)];
    demo2Lbl.text = @"颜色:";
    [demo2View addSubview:demo2Lbl];
    MZPageControl *demo2PageControl = [[MZPageControl alloc] initWithFrame:CGRectMake(66, 0, 300, 30)];
    demo2PageControl.numberOfPages = 6;
    demo2PageControl.currentPage = 2;
    demo2PageControl.pageIndicatorTintColor = [UIColor greenColor];
    demo2PageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    [demo2View addSubview:demo2PageControl];
    
    UIView *demo3View = [[UIView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 30)];
    demo3View.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:demo3View];
    UILabel *demo3Lbl = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 50, 30)];
    demo3Lbl.text = @"形状:";
    [demo3View addSubview:demo3Lbl];
    MZPageControl *demo3PageControl = [[MZPageControl alloc] initWithFrame:CGRectMake(66, 0, 300, 30)];
    demo3PageControl.numberOfPages = 6;
    demo3PageControl.currentPage = 2;
    demo3PageControl.pageSize = CGSizeMake(10, 5);
    demo3PageControl.currentPageSize = CGSizeMake(20, 10);
    [demo3View addSubview:demo3PageControl];
    
    UIView *demo4View = [[UIView alloc] initWithFrame:CGRectMake(0, 250, self.view.frame.size.width, 30)];
    demo4View.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:demo4View];
    UILabel *demo4Lbl = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 50, 30)];
    demo4Lbl.text = @"位置:";
    [demo4View addSubview:demo4Lbl];
    MZPageControl *demo4PageControl = [[MZPageControl alloc] initWithFrame:CGRectMake(66, 0, 300, 30)];
    demo4PageControl.numberOfPages = 6;
    demo4PageControl.currentPage = 2;
    demo4PageControl.alignment = AlignmentRight;
    demo4PageControl.currentPageSize = CGSizeMake(16, 8);
    [demo4View addSubview:demo4PageControl];
    
    UIView *demo5View = [[UIView alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 30)];
    demo5View.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:demo5View];
    UILabel *demo5Lbl = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 50, 30)];
    demo5Lbl.text = @"圆角:";
    [demo5View addSubview:demo5Lbl];
    MZPageControl *demo5PageControl = [[MZPageControl alloc] initWithFrame:CGRectMake(66, 0, 300, 30)];
    demo5PageControl.numberOfPages = 6;
    demo5PageControl.currentPage = 2;
    demo5PageControl.alignment = AlignmentLeft;
    demo5PageControl.pageSize = CGSizeMake(10, 5);
    demo5PageControl.currentPageSize = CGSizeMake(20, 10);
    demo5PageControl.pageCornerRadius = 3;
    demo5PageControl.currentPageCornerRadius = 8;
    [demo5View addSubview:demo5PageControl];
}


@end
