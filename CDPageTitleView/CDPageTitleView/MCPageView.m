//
//  MCSegmentView.m
//  mixc
//
//  Created by Genius on 01/08/2017.
//  Copyright © 2017 crland. All rights reserved.
//

#import "MCPageView.h"
#import <UIView+YYAdd.h>
#import <UIColor+YYAdd.h>
#import <YYCGUtilities.h>

const CGFloat kMCSegmentViewHeight = 43;

@interface MCPageView ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *bottomLine;
@end


@implementation MCPageView {
    NSArray<NSString *> *_titleNames;               // 标题数组
    NSMutableArray<UIButton *> *_buttonList;        // 按钮数组
    NSMutableArray *_titleNameWidth;                // 标题的宽度
    CGFloat _allButtonWidth;                        // 所有按钮的宽度和
    BOOL _canScroll;                                // 是否可滑动(如果不可, 则平铺; 否则按照按钮大小排列)
    NSInteger _selectedButtonIndex;                 // 当前选中的button-tag
    
}

#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray<NSString *> *)titleNames {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // initData
        _buttonList = [NSMutableArray array];
        _titleNameWidth = [NSMutableArray array];
        _allButtonWidth = 0.f;
        _titleNames = titleNames;
        
        
        // scrollView
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.bounces = NO;
        self.scrollView.alwaysBounceHorizontal = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.frame = self.bounds;
        self.scrollView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.scrollView];
        
        
        // 创建按钮
        for (int i = 0; i < _titleNames.count; i++) {
            NSString *str = _titleNames[i];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:str forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithHexString:@"#FE8A3D"] forState:UIControlStateSelected];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            btn.tag = i;
            
            CGFloat strW = [self calculateStringWidth:str];
            [_titleNameWidth addObject:@(strW)];
            // 每个按钮增加20宽
            _allButtonWidth += (strW + 20);
            [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_buttonList addObject:btn];
        }
        
        
        // 添加按钮
        _canScroll = (_allButtonWidth > self.width);
        self.scrollView.bounces = _canScroll;
        
        CGFloat x = 0.f, y = 0.f, w = 0.f, h = self.height;
        if (_canScroll) {
            for (int i = 0; i < _buttonList.count; i++) {
                UIButton *btn = _buttonList[i];
                btn.left = x;
                btn.top = y;
                btn.width = [_titleNameWidth[i] floatValue] + 20;
                btn.height = h;
                x += btn.width;
                [self.scrollView addSubview:btn];
            }
            self.scrollView.contentSize = CGSizeMake(_allButtonWidth, 0);
            
        }else {
            w = self.width / _buttonList.count;
            
            for (int i = 0; i < _buttonList.count; i++) {
                UIButton *btn = _buttonList[i];
                btn.left = x;
                btn.top = y;
                btn.width = w;
                btn.height = h;
                
                x += w;
                [self.scrollView addSubview:btn];
            }
            
            self.scrollView.contentSize = CGSizeMake(self.width, 0);
        }
        
        // 添加底部line
        self.bottomLine = [UIView new];
        self.bottomLine.backgroundColor = [UIColor colorWithHexString:@"#FE8A3D"];
        self.bottomLine.size = CGSizeMake([_titleNameWidth[0] floatValue], 2.f);
        self.bottomLine.centerX = _buttonList[0].centerX;
        self.bottomLine.bottom = self.height;
        [self.scrollView addSubview:self.bottomLine];
        
        
        // 默认点击第一个
        self.currentIndex = 0;
        
    }
    
    
    return self;
}









#pragma mark - Action
- (void)buttonClicked:(UIButton *)button {
    // callBack
    !self.selectedButtonCall ? : self.selectedButtonCall([_buttonList indexOfObject:button]);
}



#pragma mark - Setter
- (void)setCurrentIndex:(NSInteger)currentIndex {
    if ((currentIndex < 0) || (currentIndex > _titleNames.count - 1)) return;
    
    _currentIndex = currentIndex;
    [self adjustTitleViewSelectedAppearence:_currentIndex];
}





#pragma mark - Private Method
// 修改按钮的选中状态
- (void)adjustTitleViewSelectedAppearence:(NSInteger)index {
    
    // 调整按钮状态
    _buttonList[_selectedButtonIndex].selected = NO;
    _selectedButtonIndex = index;
    UIButton *button = _buttonList[index];
    button.selected = YES;
    
    // 调整自身位置
    CGFloat scrollX = button.left - self.scrollView.width * .5;
    if (scrollX < 0) {
        scrollX = 0;
    }
    if (scrollX > (self.scrollView.contentSize.width - self.scrollView.width)) {
        scrollX = (self.scrollView.contentSize.width - self.scrollView.width);
    }

    // 提交动画
    [UIView animateWithDuration:0.3 animations:^{
        [self.scrollView setContentOffset:CGPointMake(scrollX, 0)];
        self.bottomLine.width = [_titleNameWidth[index] floatValue];
        self.bottomLine.centerX = button.centerX;
    } completion:^(BOOL finished) {
        //
    }];
}


// 计算文本宽度
- (CGFloat)calculateStringWidth:(NSString *)string {
    CGFloat w = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.f]}
                                     context:nil].size.width;
    return w;
}








@end
