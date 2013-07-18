//
//  EUNavigationController.m
//  PopDemo
//
//  Created by csj on 13-7-18.
//  Copyright (c) 2013年 eu. All rights reserved.
//

#import "EUNavigationController.h"

@interface EUNavigationController ()

@end

@implementation EUNavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        NSLog(@"eu nav init");
        _imageNavigationBars = [[NSMutableArray alloc] init];
    }

    return self;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //截图
    [_imageNavigationBars addObject:[self.navigationBar imageByRenderingView]];
    
    [super pushViewController:viewController animated:animated];
}

//各种方式删除截图
- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    UIViewController *controller = [super popViewControllerAnimated:animated];
    
    if (_imageNavigationBars.count > 0) {
        [_imageNavigationBars removeLastObject];
    } else {
        NSLog(@"EUNav fail.");
    }
    
    return controller;
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSArray *popedControllers = [super popToViewController:viewController animated:animated];
    
    if (_imageNavigationBars.count >= popedControllers.count) {
        [_imageNavigationBars removeObjectsInRange:NSMakeRange(_imageNavigationBars.count - popedControllers.count, popedControllers.count)];
    } else {
        NSLog(@"EUNav fail.");
    }
    return popedControllers;
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    NSArray *popedControllers = [super popToRootViewControllerAnimated:animated];
    
    [_imageNavigationBars removeAllObjects];
    return popedControllers;
}

@end
