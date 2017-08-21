//
//  MCSegmentView.m
//  CDPageTitleView
//
//  Created by Genius on 18/08/2017.
//  Copyright © 2017 Genius. All rights reserved.
//

#import "MCSegmentView.h"
#import <YYKit.h>
#import "MCPageView.h"

static NSString *const kMCCollectionViewCellIdentify = @"kMCCollectionViewCellIdentify";

@interface MCSegmentView ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIViewController *parentVC;
@property (nonatomic, strong) NSArray<UIViewController *> *childControllers;
@property (nonatomic, strong) NSArray<NSString *> *titleArray;

@property (nonatomic, strong) MCPageView *pageView;
@property (nonatomic, strong) UIScrollView *contentScrollView;

@end

@implementation MCSegmentView

- (instancetype)initWithFrame:(CGRect)frame
                     parentVC:(UIViewController *)parentVC
                   titleArray:(NSArray <NSString *>*)titleArray
                      childControllers:(NSArray <UIViewController *>*)childControllers {
    self = [super initWithFrame:frame];
    if (self) {
        
        // 初始化值
        self.parentVC = parentVC;
        self.childControllers = childControllers;
        
        // 标题scrollView
        self.pageView = [[MCPageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kMCSegmentViewHeight) titleNames:titleArray];
        [self.pageView setSelectedButtonCall:^(NSInteger index){
            CGFloat offsetX = kScreenWidth * index;
            [self.contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        }];
        [self addSubview:self.pageView];
        
        // 添加子控制器
        for (UIViewController *vc in self.childControllers) {
            [self.parentVC addChildViewController:vc];
        }
        
        // 内容scrollView
        self.contentScrollView = [[UIScrollView alloc] init];
        self.contentScrollView.frame = CGRectMake(0, kMCSegmentViewHeight, kScreenWidth, self.height - kMCSegmentViewHeight);
        self.contentScrollView.delegate = self;
        self.contentScrollView.scrollsToTop = NO;
        self.contentScrollView.showsHorizontalScrollIndicator = NO;
        self.contentScrollView.showsVerticalScrollIndicator = NO;
        self.contentScrollView.pagingEnabled = YES;
        self.contentScrollView.contentSize = CGSizeMake(kScreenWidth * self.parentVC.childViewControllers.count, 0);
        self.contentScrollView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.contentScrollView];
        
        // 添加默认控制器
        UIViewController *defaultVC = self.parentVC.childViewControllers.firstObject;
        defaultVC.view.frame = self.contentScrollView.bounds;
        [self.contentScrollView addSubview:defaultVC.view];
        
    }
    return self;
}




#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffset = scrollView.contentOffset.x;
    NSInteger page = (NSInteger)((contentOffset + self.contentScrollView.width / 2) / self.contentScrollView.width);
    //> 调整标题
    self.pageView.currentIndex = page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.contentScrollView) {
        [self adjustContentScrollView:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView == self.contentScrollView) {
        [self adjustContentScrollView:scrollView];
    }
}

// 添加子控制器的视图
- (void)adjustContentScrollView:(UIScrollView *)scrollView {
    if (scrollView == self.contentScrollView) {
        NSInteger index = scrollView.contentOffset.x / self.contentScrollView.width;
        self.pageView.currentIndex = index;
        
        UIViewController *vc = self.parentVC.childViewControllers[index];
        if (vc.view.superview) return;
        vc.view.frame = CGRectMake(index * self.contentScrollView.width, 0, kScreenWidth, self.height - kMCSegmentViewHeight);
        [self.contentScrollView addSubview:vc.view];
    }
}


@end
