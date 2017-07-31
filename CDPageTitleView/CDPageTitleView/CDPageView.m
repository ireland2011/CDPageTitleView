//
//  CDPageView.m
//  CDPageTitleView
//
//  Created by Genius on 31/7/2017.
//  Copyright © 2017 Genius. All rights reserved.
//

#import "CDPageView.h"

@interface CDPageView ()
@property (nonatomic, strong) UIScrollView *scrollView;
@end


@implementation CDPageView {
    NSArray<NSString *> *_titleNames;
}

#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray<NSString *> *)titleNames {
    self = [super initWithFrame:frame];
    if (self) {
        // 数据
        _titleNames = titleNames;
        
        // scrollView
        self.scrollView = [UIScrollView new];
        self.scrollView.alwaysBounceHorizontal = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.frame = self.bounds;
        [self addSubview:self.scrollView];
        
        
        // 添加按钮
        
        
    }
    return self;
}




@end
