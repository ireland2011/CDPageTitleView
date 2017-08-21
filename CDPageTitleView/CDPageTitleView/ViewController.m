//
//  ViewController.m
//  CDPageTitleView
//
//  Created by Genius on 31/7/2017.
//  Copyright © 2017 Genius. All rights reserved.
//

#import "ViewController.h"
#import "MCPageView.h"
#import "MCSegmentView.h"
#import "MCSegmentViewVC.h"
#import <YYKit.h>


@interface ViewController ()
@property (nonatomic, strong) MCSegmentView *segmentView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    NSArray *titleArray = @[@"分类A", @"分类B分类B", @"分类C分类C分类C分类C", @"分类D分类D", @"分类E", @"其他"];
    NSArray<UIViewController *>*childVC = @[[MCSegmentViewVC new], [MCSegmentViewVC new], [MCSegmentViewVC new], [MCSegmentViewVC new], [MCSegmentViewVC new], [MCSegmentViewVC new]];
    
    self.segmentView = [[MCSegmentView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)
                                                   parentVC:self
                                                 titleArray:titleArray
                                                    childControllers:childVC];
    
    [self.view addSubview:self.segmentView];
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}



@end
