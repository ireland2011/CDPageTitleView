//
//  MCSegmentView.h
//  CDPageTitleView
//
//  Created by Genius on 18/08/2017.
//  Copyright © 2017 Genius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCSegmentView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                     parentVC:(UIViewController *)parentVC
                   titleArray:(NSArray <NSString *>*)titleArray
                      childControllers:(NSArray <UIViewController *>*)childControllers;

@property (nonatomic, copy) void (^collectionCurrentIndexBlock)(NSInteger index);

@end
