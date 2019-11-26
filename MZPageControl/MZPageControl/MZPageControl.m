//
//  MZPageControl.m
//  MZPageControl
//
//  Created by 木木 on 2019/11/18.
//  Copyright © 2019 Mr.Z. All rights reserved.
//

#import "MZPageControl.h"

@interface MZPageControl()

@property (nonatomic, strong) NSMutableArray *pages;
@property (nonatomic, strong) NSMutableArray *pageNumbers;

@end

@implementation MZPageControl

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
    self.pageSpacing = 8;
    self.pageSize = CGSizeMake(8, 8);
    self.currentPageSize = self.pageSize;
    self.alignment = AlignmentCenter;
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
}

- (void)setNumberOfPages:(NSInteger)numberOfPages {
    _numberOfPages = numberOfPages;
    [self setupPages];
}

- (void)setCurrentPage:(NSInteger)currentPage {
    _currentPage = currentPage;
    [self changeColor];
    [self updateFrame];
    [self updatePageNumber];
    [self updatePageBorder];
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
        imageView.userInteractionEnabled = YES;
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
        case AlignmentLeft:
            pageX = self.pageSpacing;
            break;
        case AlignmentRight:
            pageX = self.frame.size.width - totalW - self.pageSpacing;
            break;
        case AlignmentCenter:
            pageX = (self.frame.size.width - totalW) / 2 + self.pageSpacing;
            break;
        default:
            break;
    }
    CGFloat width = index == self.currentPage ? self.currentPageSize.width : self.pageSize.width;
    CGFloat height = index == self.currentPage ? self.currentPageSize.height : self.pageSize.height;
    CGFloat x = index <= self.currentPage ? pageX + pageW * index : pageX + pageW * (index - 1) + currentPageW;
    CGFloat y = (self.frame.size.height - height) / 2;
    return CGRectMake(x, y, width, height);
}

- (void)updateFrame {
    for (NSInteger i = 0; i < self.pages.count; i++) {
        CGRect frame = [self getFrame:i];
        UIImageView *imageView = (UIImageView *)self.pages[i];
        imageView.frame = frame;
        CGFloat radius = self.pageCornerRadius == 0 ? frame.size.height / 2 : self.pageCornerRadius;
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
    NSInteger index = tap.view.tag - 1000;
    [self setCurrentPage:index];
    if (self.pageClickBlock) {
        self.pageClickBlock(index);
    }
}

@end
