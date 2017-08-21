//
//  MCSegmentView.h
//  mixc
//
//  Created by Genius on 01/08/2017.
//  Copyright © 2017 crland. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN const CGFloat kMCSegmentViewHeight;

@interface MCPageView : UIView

- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray <NSString *>*)titleNames;

@property (nonatomic, copy) void (^selectedButtonCall)(NSInteger index);
@property (nonatomic, assign) NSInteger currentIndex;

@end
