# MZPageControl
自定义PageControl

效果图：

![image](https://github.com/MrZhou1010/MZPageControl/blob/master/demo.png)

实现：

默认的状态

    UIView *demo1View = [[UIView alloc] initWithFrame:CGRectMake(0, 100.0, self.view.frame.size.width, 30.0)];
    demo1View.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:demo1View];
    UILabel *demo1Lbl = [[UILabel alloc] initWithFrame:CGRectMake(16.0, 0, 50.0, 30.0)];
    demo1Lbl.text = @"默认:";
    [demo1View addSubview:demo1Lbl];
    MZPageControl *demo1PageControl = [[MZPageControl alloc] initWithFrame:CGRectMake(66.0, 0.0, 300.0, 30.0)];
    demo1PageControl.numberOfPages = 6;
    demo1PageControl.animationEnable = YES;
    demo1PageControl.currentPage = 0;
    [demo1View addSubview:demo1PageControl];

修改颜色的状态

    UIView *demo2View = [[UIView alloc] initWithFrame:CGRectMake(0, 150.0, self.view.frame.size.width, 30.0)];
    demo2View.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:demo2View];
    UILabel *demo2Lbl = [[UILabel alloc] initWithFrame:CGRectMake(16.0, 0, 50.0, 30.0)];
    demo2Lbl.text = @"颜色:";
    [demo2View addSubview:demo2Lbl];
    MZPageControl *demo2PageControl = [[MZPageControl alloc] initWithFrame:CGRectMake(66.0, 0, 300.0, 30.0)];
    demo2PageControl.numberOfPages = 6;
    demo2PageControl.animationEnable = YES;
    demo2PageControl.currentPage = 2;
    demo2PageControl.pageIndicatorTintColor = [UIColor greenColor];
    demo2PageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    [demo2View addSubview:demo2PageControl];

修改形状的状态

    UIView *demo3View = [[UIView alloc] initWithFrame:CGRectMake(0, 200.0, self.view.frame.size.width, 30.0)];
    demo3View.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:demo3View];
    UILabel *demo3Lbl = [[UILabel alloc] initWithFrame:CGRectMake(16.0, 0, 50.0, 30.0)];
    demo3Lbl.text = @"形状:";
    [demo3View addSubview:demo3Lbl];
    MZPageControl *demo3PageControl = [[MZPageControl alloc] initWithFrame:CGRectMake(66.0, 0, 300.0, 30.0)];
    demo3PageControl.numberOfPages = 6;
    demo3PageControl.currentPage = 2;
    demo3PageControl.pageSize = CGSizeMake(10.0, 5.0);
    demo3PageControl.currentPageSize = CGSizeMake(20.0, 10.0);
    [demo3View addSubview:demo3PageControl];

修改位置的状态

    UIView *demo4View = [[UIView alloc] initWithFrame:CGRectMake(0, 250.0, self.view.frame.size.width, 30.0)];
    demo4View.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:demo4View];
    UILabel *demo4Lbl = [[UILabel alloc] initWithFrame:CGRectMake(16.0, 0, 50.0, 30.0)];
    demo4Lbl.text = @"位置:";
    [demo4View addSubview:demo4Lbl];
    MZPageControl *demo4PageControl = [[MZPageControl alloc] initWithFrame:CGRectMake(66.0, 0, 300.0, 30.0)];
    demo4PageControl.numberOfPages = 6;
    demo4PageControl.alignment = MZPageControlAlignmentRight;
    demo4PageControl.currentPageSize = CGSizeMake(16.0, 8.0);
    demo4PageControl.animationEnable = YES;
    demo4PageControl.currentPage = 2;
    [demo4View addSubview:demo4PageControl];

修改圆角的状态

    UIView *demo5View = [[UIView alloc] initWithFrame:CGRectMake(0, 300.0, self.view.frame.size.width, 30.0)];
    demo5View.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:demo5View];
    UILabel *demo5Lbl = [[UILabel alloc] initWithFrame:CGRectMake(16.0, 0, 50.0, 30.0)];
    demo5Lbl.text = @"圆角:";
    [demo5View addSubview:demo5Lbl];
    MZPageControl *demo5PageControl = [[MZPageControl alloc] initWithFrame:CGRectMake(66.0, 0, 300.0, 30.0)];
    demo5PageControl.numberOfPages = 6;
    demo5PageControl.currentPage = 2;
    demo5PageControl.alignment = MZPageControlAlignmentLeft;
    demo5PageControl.pageSize = CGSizeMake(10.0, 6.0);
    demo5PageControl.currentPageSize = CGSizeMake(20.0, 10.0);
    demo5PageControl.pageCornerRadius = 3.0;
    demo5PageControl.currentPageCornerRadius = 6.0;
    [demo5View addSubview:demo5PageControl];

将图片作为page的状态

    UIView *demo6View = [[UIView alloc] initWithFrame:CGRectMake(0, 350.0, self.view.frame.size.width, 30.0)];
    demo6View.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:demo6View];
    UILabel *demo6Lbl = [[UILabel alloc] initWithFrame:CGRectMake(16.0, 0, 50.0, 30.0)];
    demo6Lbl.text = @"图片:";
    [demo6View addSubview:demo6Lbl];
    MZPageControl *demo6PageControl = [[MZPageControl alloc] initWithFrame:CGRectMake(66.0, 0, 300.0, 30.0)];
    demo6PageControl.numberOfPages = 6;
    demo6PageControl.currentPage = 2;
    demo6PageControl.pageSize = CGSizeMake(20.0, 20.0);
    demo6PageControl.currentPageSize = CGSizeMake(25.0, 25.0);
    demo6PageControl.pageImage = [UIImage imageNamed:@"home_icon_schedule_gary"];
    demo6PageControl.currentPageImage = [UIImage imageNamed:@"home_icon_schedule_current"];
    [demo6View addSubview:demo6PageControl];

添加序号的状态

    UIView *demo7View = [[UIView alloc] initWithFrame:CGRectMake(0, 400.0, self.view.frame.size.width, 30.0)];
    demo7View.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:demo7View];
    UILabel *demo7Lbl = [[UILabel alloc] initWithFrame:CGRectMake(16.0, 0, 50.0, 30.0)];
    demo7Lbl.text = @"序号:";
    [demo7View addSubview:demo7Lbl];
    MZPageControl *demo7PageControl = [[MZPageControl alloc] initWithFrame:CGRectMake(66.0, 0, 300.0, 30.0)];
    demo7PageControl.numberOfPages = 6;
    demo7PageControl.currentPage = 3;
    demo7PageControl.pageSize = CGSizeMake(20.0, 20.0);
    demo7PageControl.currentPageSize = CGSizeMake(26.0, 26.0);
    demo7PageControl.pageCornerRadius = 10.0;
    demo7PageControl.currentPageCornerRadius = 13.0;
    demo7PageControl.showPageNumber = YES;
    demo7PageControl.pageNumberColor = [UIColor orangeColor];
    demo7PageControl.currentPageNumberColor = [UIColor purpleColor];
    demo7PageControl.pageNumberFont = [UIFont systemFontOfSize:10];
    demo7PageControl.currentPageNumberFont = [UIFont systemFontOfSize:13];
    [demo7View addSubview:demo7PageControl];

添加边框的状态,形成同心圆效果

    UIView *demo8View = [[UIView alloc] initWithFrame:CGRectMake(0, 450.0, self.view.frame.size.width, 30.0)];
    demo8View.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:demo8View];
    UILabel *demo8Lbl = [[UILabel alloc] initWithFrame:CGRectMake(16.0, 0, 50.0, 30.0)];
    demo8Lbl.text = @"边框:";
    [demo8View addSubview:demo8Lbl];
    MZPageControl *demo8PageControl = [[MZPageControl alloc] initWithFrame:CGRectMake(66.0, 0, 300.0, 30.0)];
    demo8PageControl.numberOfPages = 6;
    demo8PageControl.currentPage = 2;
    demo8PageControl.pageSize = CGSizeMake(20.0, 20.0);
    demo8PageControl.currentPageSize = CGSizeMake(26.0, 26.0);
    demo8PageControl.pageCornerRadius = 10.0;
    demo8PageControl.currentPageCornerRadius = 13.0;
    demo8PageControl.showPageBorder = YES;
    demo8PageControl.pageBorderColor = [UIColor whiteColor];
    demo8PageControl.currentPageBorderColor = [UIColor grayColor];
    demo8PageControl.pageBorderWidth = 3.0;
    demo8PageControl.currentPageBorderWidth = 5.0;
    demo8PageControl.clickEnable = NO;
    [demo8View addSubview:demo8PageControl];
