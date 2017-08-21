//
//  ViewController.h
//  CDPageTitleView
//
//  Created by Genius on 31/7/2017.
//  Copyright © 2017 Genius. All rights reserved.
//

#import <UIKit/UIKit.h>

#define COLOR_RANDOM                COLOR_RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))    // 生成随机颜色
#define COLOR_RGB(r,g,b)            [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]

@interface ViewController : UIViewController


@end

