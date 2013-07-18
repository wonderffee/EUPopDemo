//
//  EUPopAnimation.m
//  PopDemo
//
//  Created by csj on 13-7-18.
//  Copyright (c) 2013年 eu. All rights reserved.
//

#import "EUPopAnimation.h"

@interface EUPopAnimation ()  {
    UIViewController *_currentController;
    
    CGPoint _pointBegan;
    
    UIView *_animationBg;
    UIView *_currentView;
    UIView *_lastView;
    UIView *_lastViewShadow;
    int isAdded;
}

@end

@implementation EUPopAnimation

- (id)init {
    self = [super init];
    if (self) {
        isAdded = 0;
    }
    
    return self;
}

- (void)begain:(CGPoint)point controller:(UIViewController *)controller {
    _currentController = controller;
    _pointBegan = point;
    
    if (isAdded == 0) {
        _currentView = [self getCurrentView];
        _lastView = [self getlastView];
        _animationBg = [self animationBg];
        
        [_animationBg addSubview:_lastView];
        [_animationBg addSubview:_currentView];
        [_currentController.view.window addSubview:_animationBg];
        isAdded = 1;
    }
}

- (void)moved:(CGPoint)point {
    float moveX = point.x - _pointBegan.x;
    //NSLog(@"move x is: %f", moveX);
    
    if (moveX < 0) {
        moveX = 0;
    }
    CGRect oldFrame = _currentView.frame;
    oldFrame.origin.x = moveX;
    _currentView.frame = oldFrame;
    
    
    float lastViewX = (320 - moveX) / 320  * 5;
    float lastViewY = (320 - moveX) / 320 * 8;
    _lastViewShadow.alpha = (320 - moveX) / 320 * 0.5;
    _lastView.frame = CGRectMake(lastViewX, lastViewY, 320, 460);
}

- (void)end:(CGPoint)point {
    //开始动画
    [UIView animateWithDuration:0.35 animations:^{
        CGRect oldFrame = _currentView.frame;
        oldFrame.origin.x = 320;
        _currentView.frame = oldFrame;
        _lastViewShadow.alpha = 0;
        _lastView.frame = CGRectMake(0, 0, 320, 460);
    } completion:^(BOOL finished) {
        [_animationBg removeFromSuperview];
        [_currentController.navigationController popViewControllerAnimated:NO];
    }];
}

- (UIView *)animationBg {
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, 460)];
    bg.backgroundColor = [UIColor blackColor]; //status bar color
    return bg;
}

- (UIView *)getCurrentView {
    UIView *currentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    
    //nav
    UIImage *bottomImage = [_currentController.navigationController.navigationBar imageByRenderingView];
    UIImageView *imageNav = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    imageNav.image = bottomImage;
    [currentView addSubview:imageNav];
    
    //view
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 320, 416)];
    imageView.image = [_currentController.view imageByRenderingView];
    [currentView addSubview:imageView];
    
    return currentView;
}

- (UIView *)getlastView {
    UIView *lastView = [[UIView alloc] initWithFrame:CGRectMake(5, 8, 320, 460)];
    
    //nav
    EUNavigationController *nav = (EUNavigationController *)_currentController.navigationController;
    UIImage *bottomImage = [nav.imageNavigationBars lastObject];
    UIImageView *imageNav = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    imageNav.image = bottomImage;
    [lastView addSubview:imageNav];
    
    //view
    UIViewController *bottomView = [_currentController.navigationController.viewControllers objectAtIndex:_currentController.navigationController.viewControllers.count - 2];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 320, 416)];
    imageView.image = [bottomView.view imageByRenderingView];
    [lastView addSubview:imageView];
    
    _lastViewShadow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, lastView.frame.size.width, lastView.frame.size.height)];
    _lastViewShadow.backgroundColor = [UIColor blackColor];
    _lastViewShadow.alpha = 0.5;
    [lastView addSubview:_lastViewShadow];
    
    return lastView;
}
@end
