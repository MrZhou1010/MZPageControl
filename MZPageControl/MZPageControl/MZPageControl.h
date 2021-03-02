//
//  MZPageControl.h
//  MZPageControl
//
//  Created by Mr.Z on 2019/11/18.
//  Copyright © 2019 Mr.Z. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MZPageControlAlignment) {
    MZPageControlAlignmentLeft = 0,     /// 居左
    MZPageControlAlignmentCenter = 1,   /// 居中
    MZPageControlAlignmentRight = 2     /// 居右
};

@interface MZPageControl : UIControl

/// page个数,默认为0
@property (nonatomic, assign) NSInteger numberOfPages;
/// 当前page,默认为0
@property (nonatomic, assign) NSInteger currentPage;
/// page间隔,默认为8.0
@property (nonatomic, assign) CGFloat pageSpacing;
/// page大小,默认为(8.0,8.0)
@property (nonatomic, assign) CGSize pageSize;
/// 当前page大小,默认为(8.0,8.0)
@property (nonatomic, assign) CGSize currentPageSize;
/// page位置,默认为居中
@property (nonatomic, assign) MZPageControlAlignment alignment;
/// page圆角
@property (nonatomic, assign) CGFloat pageCornerRadius;
/// 当前page圆角
@property (nonatomic, assign) CGFloat currentPageCornerRadius;
/// page颜色,默认为gray
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
/// 当前page颜色,默认为white
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;
/// 以image作为page
@property (nonatomic, strong) UIImage *pageImage;
/// 当前page的image
@property (nonatomic, strong) UIImage *currentPageImage;
/// 是否显示page的序号,默认为NO
@property (nonatomic, assign, getter = isShowPageNumber) BOOL showPageNumber;
/// page的序号文字颜色,默认为lightGrayColor
@property (nonatomic, strong) UIColor *pageNumberColor;
/// page的序号文字字体,默认为8.0
@property (nonatomic, strong) UIFont *pageNumberFont;
/// 当前page的序号文字颜色,默认为blackColor
@property (nonatomic, strong) UIColor *currentPageNumberColor;
/// 当前page的序号文字字体,默认为8.0
@property (nonatomic, strong) UIFont *currentPageNumberFont;
/// 是否显示page的边框,默认为NO
@property (nonatomic, assign, getter = isShowPageBorder) BOOL showPageBorder;
/// page的边框宽度,默认为1.0
@property (nonatomic, assign) CGFloat pageBorderWidth;
/// page的边框颜色,默认为whiteColor
@property (nonatomic, strong) UIColor *pageBorderColor;
/// 当前page的边框宽度,默认为1.0
@property (nonatomic, assign) CGFloat currentPageBorderWidth;
/// 当前page的边框颜色,默认为gray
@property (nonatomic, strong) UIColor *currentPageBorderColor;
/// 是否可以点击page,默认为YES
@property (nonatomic, assign, getter = isClickEnable) BOOL clickEnable;
/// 点击page的回调
@property (nonatomic, copy) void(^pageClickBlock)(NSInteger index);
/// 是否动画,默认为NO
@property (nonatomic, assign, getter = isAnimationEnable) BOOL animationEnable;

@end

NS_ASSUME_NONNULL_END
