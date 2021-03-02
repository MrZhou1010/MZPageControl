//
//  MZPageControl.m
//  MZPageControl
//
//  Created by Mr.Z on 2019/11/18.
//  Copyright © 2019 Mr.Z. All rights reserved.
//

#import "MZPageControl.h"

@interface MZPageControl()

@property (nonatomic, strong) NSMutableArray *pages;
@property (nonatomic, strong) NSMutableArray *pageNumbers;
@property (nonatomic, assign) BOOL isAnimating;

@end

@implementation MZPageControl

#pragma mark - 初始化
- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.backgroundColor = [UIColor clearColor];
    self.pages = [NSMutableArray array];
    self.pageNumbers = [NSMutableArray array];
    self.numberOfPages = 0;
    self.currentPage = 0;
    self.pageSpacing = 8.0;
    self.pageSize = CGSizeMake(8.0, 8.0);
    self.currentPageSize = self.pageSize;
    self.alignment = MZPageControlAlignmentCenter;
    self.pageIndicatorTintColor = [UIColor grayColor];
    self.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.showPageNumber = NO;
    self.pageNumberColor = [UIColor lightGrayColor];
    self.pageNumberFont = [UIFont systemFontOfSize:8.0];
    self.currentPageNumberColor = [UIColor blackColor];
    self.currentPageNumberFont = [UIFont systemFontOfSize:8.0];
    self.showPageBorder = NO;
    self.pageBorderColor = [UIColor whiteColor];
    self.pageBorderWidth = 1.0;
    self.currentPageBorderColor = [UIColor grayColor];
    self.currentPageBorderWidth = 1.0;
    self.clickEnable = YES;
    self.animationEnable = NO;
    self.isAnimating = NO;
}

#pragma mark - 属性
- (void)setNumberOfPages:(NSInteger)numberOfPages {
    _numberOfPages = numberOfPages;
    [self setupPages];
}

- (void)setCurrentPage:(NSInteger)currentPage {
    if (self.animationEnable) {
        [self changeColor];
        [self updateFrame];
        if (currentPage == _currentPage || self.isAnimating) {
            return;
        }
        if (currentPage > _currentPage) {
            [self startAnimationToRight:currentPage];
        } else {
            [self startAnimationToLeft:currentPage];
        }
    } else {
        _currentPage = currentPage;
        [self changeColor];
        [self updateFrame];
        [self updatePageNumber];
        [self updatePageBorder];
    }
}

- (void)setPageSpacing:(CGFloat)pageSpacing {
    _pageSpacing = pageSpacing;
    [self updateFrame];
}

- (void)setPageSize:(CGSize)pageSize {
    _pageSize = pageSize;
    [self updateFrame];
}

- (void)setCurrentPageSize:(CGSize)currentPageSize {
    _currentPageSize = currentPageSize;
    [self updateFrame];
}

- (void)setAlignment:(MZPageControlAlignment)alignment {
    _alignment = alignment;
    [self updateFrame];
}

- (void)setPageCornerRadius:(CGFloat)pageCornerRadius {
    _pageCornerRadius = pageCornerRadius;
    [self updateFrame];
}

- (void)setCurrentPageCornerRadius:(CGFloat)currentPageCornerRadius {
    _currentPageCornerRadius = currentPageCornerRadius;
    [self updateFrame];
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    _pageIndicatorTintColor = pageIndicatorTintColor;
    [self changeColor];
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    [self changeColor];
}

- (void)setPageImage:(UIImage *)pageImage {
    _pageImage = pageImage;
    [self changeColor];
}

- (void)setCurrentPageImage:(UIImage *)currentPageImage {
    _currentPageImage = currentPageImage;
    [self changeColor];
}

- (void)setShowPageNumber:(BOOL)showPageNumber {
    _showPageNumber = showPageNumber;
    if (showPageNumber) {
        [self setupPageNumber];
    }
}

- (void)setPageNumberColor:(UIColor *)pageNumberColor {
    _pageNumberColor = pageNumberColor;
    [self updatePageNumber];
}

- (void)setPageNumberFont:(UIFont *)pageNumberFont {
    _pageNumberFont = pageNumberFont;
    [self updatePageNumber];
}

- (void)setCurrentPageNumberColor:(UIColor *)currentPageNumberColor {
    _currentPageNumberColor = currentPageNumberColor;
    [self updatePageNumber];
}

- (void)setCurrentPageNumberFont:(UIFont *)currentPageNumberFont {
    _currentPageNumberFont = currentPageNumberFont;
    [self updatePageNumber];
}

- (void)setShowPageBorder:(BOOL)showPageBorder {
    _showPageBorder = showPageBorder;
    [self updatePageBorder];
}

- (void)setPageBorderColor:(UIColor *)pageBorderColor {
    _pageBorderColor = pageBorderColor;
    [self updatePageBorder];
}

- (void)setPageBorderWidth:(CGFloat)pageBorderWidth {
    _pageBorderWidth = pageBorderWidth;
    [self updatePageBorder];
}

- (void)setCurrentPageBorderColor:(UIColor *)currentPageBorderColor {
    _currentPageBorderColor = currentPageBorderColor;
    [self updatePageBorder];
}

- (void)setCurrentPageBorderWidth:(CGFloat)currentPageBorderWidth {
    _currentPageBorderWidth = currentPageBorderWidth;
    [self updatePageBorder];
}

- (void)setClickEnable:(BOOL)clickEnable {
    _clickEnable = clickEnable;
    for (NSInteger i = 0; i < self.pages.count; i++) {
        UIImageView *imageView = (UIImageView *)self.pages[i];
        imageView.userInteractionEnabled = clickEnable;
    }
}

#pragma mark - 方法
- (void)setupPages {
    if (self.pages.count > 0) {
        for (UIImageView *page in self.pages) {
            [page removeFromSuperview];
        }
        [self.pages removeAllObjects];
    }
    for (NSInteger i = 0; i < self.numberOfPages; i++) {
        CGRect frame = [self getFrame:i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.tag = 1000 + i;
        imageView.userInteractionEnabled = self.clickEnable;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pageClick:)];
        [imageView addGestureRecognizer:tap];
        [self addSubview:imageView];
        [self.pages addObject:imageView];
    }
    // 单个page隐藏
    self.hidden = self.numberOfPages <= 1 ? YES : NO;
}

- (CGRect)getFrame:(NSInteger)index {
    CGFloat pageW = self.pageSize.width + self.pageSpacing;
    CGFloat currentPageW = self.currentPageSize.width + self.pageSpacing;
    CGFloat totalW = pageW * (self.numberOfPages - 1) + currentPageW + self.pageSpacing;
    CGFloat pageX = 0.0;
    switch (self.alignment) {
        case MZPageControlAlignmentLeft:
            pageX = self.pageSpacing;
            break;
        case MZPageControlAlignmentRight:
            pageX = self.frame.size.width - totalW - self.pageSpacing;
            break;
        case MZPageControlAlignmentCenter:
            pageX = (self.frame.size.width - totalW) / 2.0 + self.pageSpacing;
            break;
        default:
            break;
    }
    CGFloat width = index == self.currentPage ? self.currentPageSize.width : self.pageSize.width;
    CGFloat height = index == self.currentPage ? self.currentPageSize.height : self.pageSize.height;
    CGFloat x = index <= self.currentPage ? pageX + pageW * index : pageX + pageW * (index - 1) + currentPageW;
    CGFloat y = (self.frame.size.height - height) / 2.0;
    return CGRectMake(x, y, width, height);
}

- (void)updateFrame {
    for (NSInteger i = 0; i < self.pages.count; i++) {
        CGRect frame = [self getFrame:i];
        UIImageView *imageView = (UIImageView *)self.pages[i];
        imageView.frame = frame;
        CGFloat radius = self.pageCornerRadius == 0 ? frame.size.height / 2.0 : self.pageCornerRadius;
        if (i == self.currentPage) {
            if (self.currentPageImage) {
                radius = 0;
            }
            imageView.layer.cornerRadius = self.currentPageCornerRadius == 0 ? radius : self.currentPageCornerRadius;
        } else {
            if (self.pageImage) {
                radius = 0;
            }
            imageView.layer.cornerRadius = radius;
        }
        imageView.layer.masksToBounds = YES;
    }
}

- (void)changeColor {
    for (NSInteger i = 0; i < self.pages.count; i++) {
        UIImageView *imageView = (UIImageView *)self.pages[i];
        if (i == self.currentPage) {
            if (self.currentPageImage) {
                imageView.image = self.currentPageImage;
                imageView.backgroundColor = [UIColor clearColor];
                imageView.layer.cornerRadius = 0;
            } else {
                imageView.backgroundColor = self.currentPageIndicatorTintColor;
            }
        } else {
            if (self.pageImage) {
                imageView.image = self.pageImage;
                imageView.backgroundColor = [UIColor clearColor];
                imageView.layer.cornerRadius = 0;
            } else {
                imageView.backgroundColor = self.pageIndicatorTintColor;
            }
        }
    }
}

- (void)setupPageNumber {
    for (NSInteger i = 0; i < self.pages.count; i++) {
        UIImageView *imageView = (UIImageView *)self.pages[i];
        UILabel *numberLbl = [[UILabel alloc] initWithFrame:imageView.bounds];
        numberLbl.text = [NSString stringWithFormat:@"%ld", (long)(i + 1)];
        numberLbl.textColor = i == self.currentPage ? self.currentPageNumberColor : self.pageNumberColor;
        numberLbl.font = i == self.currentPage ? self.currentPageNumberFont : self.pageNumberFont;
        numberLbl.textAlignment = NSTextAlignmentCenter;
        [imageView addSubview:numberLbl];
        [self.pageNumbers addObject:numberLbl];
    }
}

- (void)updatePageNumber {
    for (NSInteger i = 0; i < self.pageNumbers.count; i++) {
        UILabel *numberLbl = (UILabel *)self.pageNumbers[i];
        numberLbl.frame = CGRectMake(0, 0, [self getFrame:i].size.width, [self getFrame:i].size.height);
        numberLbl.textColor = i == self.currentPage ? self.currentPageNumberColor : self.pageNumberColor;
        numberLbl.font = i == self.currentPage ? self.currentPageNumberFont : self.pageNumberFont;
    }
}

- (void)updatePageBorder {
    if (self.showPageBorder) {
        for (NSInteger i = 0; i < self.pages.count; i++) {
            UIImageView *imageView = (UIImageView *)self.pages[i];
            imageView.layer.borderColor = i == self.currentPage ? self.currentPageBorderColor.CGColor : self.pageBorderColor.CGColor;
            imageView.layer.borderWidth = i == self.currentPage ? self.currentPageBorderWidth : self.pageBorderWidth;
        }
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    return hitView == self ? nil : hitView;
}

- (void)pageClick:(UITapGestureRecognizer *)tap {
    if (self.isAnimating) {
        return;
    }
    NSInteger index = tap.view.tag - 1000;
    [self setCurrentPage:index];
    if (self.pageClickBlock) {
        self.pageClickBlock(index);
    }
}

#pragma mark - 动画
/// 向右动画
- (void)startAnimationToRight:(NSInteger)currentPage {
    UIImageView *startView = (UIImageView *)self.pages[self->_currentPage];
    [self bringSubviewToFront:startView];
    self.isAnimating = YES;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect tempFrame = startView.frame;
        // 当前选中的圆点,x不变,宽度增加,增加几个圆点和间隙距离
        CGFloat width = self.currentPageSize.width + (self.pageSize.width + self.pageSpacing) * (currentPage - self->_currentPage);
        CGFloat height = tempFrame.size.height;
        tempFrame.size = CGSizeMake(width, height);
        startView.frame = tempFrame;
    } completion:^(BOOL finished) {
        UIImageView *endView = (UIImageView *)self.pages[currentPage];
        endView.backgroundColor = startView.backgroundColor;
        endView.frame = startView.frame;
        [self bringSubviewToFront:endView];
        startView.backgroundColor = self.pageIndicatorTintColor;
        CGFloat startX = CGRectGetMinX(startView.frame);
        for (int i = 0; i < currentPage - self->_currentPage; i++) {
            UIView *tempView = self.pages[self->_currentPage + i];
            CGRect tempFrame = tempView.frame;
            tempFrame.origin = CGPointMake(startX + (self.pageSize.width + self.pageSpacing) * i, tempFrame.origin.y);
            tempFrame.size = CGSizeMake(self.pageSize.width, self.pageSize.height);
            tempView.frame = tempFrame;
        }
        [UIView animateWithDuration:0.3 animations:^{
            endView.frame = CGRectMake(CGRectGetMaxX(endView.frame) - self.currentPageSize.width, CGRectGetMinY(endView.frame), self.currentPageSize.width, self.currentPageSize.height);
        } completion:^(BOOL finished) {
            self->_currentPage = currentPage;
            self.isAnimating = NO;
        }];
    }];
}

/// 向左动画
- (void)startAnimationToLeft:(NSInteger)currentPage {
    UIImageView *startView = (UIImageView *)self.pages[self->_currentPage];
    [self bringSubviewToFront:startView];
    self.isAnimating = YES;
    [UIView animateWithDuration:0.3 animations:^{
        // 当前选中的圆点,x向左移动,宽度增加,增加几个圆点和间隙距离
        CGFloat x = CGRectGetMinX(startView.frame) - (self.pageSize.width + self.pageSpacing) * (self->_currentPage - currentPage);
        CGFloat width = self.currentPageSize.width + (self.pageSize.width + self.pageSpacing) * (self->_currentPage - currentPage);
        startView.frame = CGRectMake(x, CGRectGetMinY(startView.frame), width, CGRectGetHeight(startView.frame));
    } completion:^(BOOL finished) {
        UIImageView *endView = (UIImageView *)self.pages[currentPage];
        endView.backgroundColor = startView.backgroundColor;
        endView.frame = startView.frame;
        [self bringSubviewToFront:endView];
        startView.backgroundColor = self.pageIndicatorTintColor;
        CGFloat startX = CGRectGetMaxX(startView.frame);
        for (int i = 0; i < self->_currentPage - currentPage; i++) {
            UIView *tempView = self.pages[self->_currentPage - i];
            CGRect tempFrame = tempView.frame;
            tempFrame.origin = CGPointMake(startX - self.pageSize.width - (self.pageSize.width + self.pageSpacing) * i, tempFrame.origin.y);
            tempFrame.size = CGSizeMake(self.pageSize.width, self.pageSize.height);
            tempView.frame = tempFrame;
        }
        [UIView animateWithDuration:0.3 animations:^{
            endView.frame = CGRectMake(CGRectGetMinX(endView.frame), CGRectGetMinY(endView.frame), self.currentPageSize.width, self.currentPageSize.height);
        } completion:^(BOOL finished) {
            self->_currentPage = currentPage;
            self.isAnimating = NO;
        }];
    }];
}

@end
