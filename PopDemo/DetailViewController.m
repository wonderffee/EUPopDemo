//
//  DetailViewController.m
//  PopDemo
//
//  Created by csj on 13-7-18.
//  Copyright (c) 2013年 eu. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () {
    UIButton *_buttonPop;
    int addbg;
    
    CGPoint pointBegan;
    
    UIView *_animationBg;
    UIView *_currentView;
    UIView *_lastView;
    UIView *_lastViewShadow;
}

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Detail View Controller";
        addbg = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _buttonPop = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _buttonPop.frame  = CGRectMake(10, 10, 70, 30);
    [_buttonPop setTitle:@"pop" forState:UIControlStateNormal];
    [_buttonPop addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_buttonPop];
    self.view.backgroundColor = [UIColor grayColor];
    
//    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)] ;
//    [panRecognizer setMaximumNumberOfTouches:1];
//    [self.view addGestureRecognizer:panRecognizer];
}

- (void)viewDidUnload {
    [super viewDidUnload];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pop {
    [self.navigationController popViewControllerAnimated:YES];
}

//-(void)handleGesture:(UIGestureRecognizer*)gestureRecognizer {
//    UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
//    NSLog(@"direction is: %f %f", [pan translationInView:self.view].x, [pan translationInView:self.view].y);
//}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint endLocation = [[touches anyObject] locationInView:self.view];
    NSLog(@"began: x:%f y:%f", endLocation.x, endLocation.y);
    pointBegan = endLocation;

    if (addbg == 0) {
        _currentView = [self getCurrentView];
        _lastView = [self getlastView];
        _animationBg = [self animationBg];
        
        [_animationBg addSubview:_lastView];
        [_animationBg addSubview:_currentView];
        [self.view.window addSubview:_animationBg];
//        [self.view.window addSubview:_lastView];
//        [self.view.window addSubview:_currentView];
        addbg = 1;
    }
}

- (UIView *)animationBg {
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, 460)];
    bg.backgroundColor = [UIColor blackColor];
    return bg;
}

- (UIView *)getCurrentView {
    UIView *currentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    
    //nav
    UIImage *bottomImage = [self.navigationController.navigationBar imageByRenderingView];
    UIImageView *imageNav = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    imageNav.image = bottomImage;
    [currentView addSubview:imageNav];
    
    //view
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 320, 416)];
    imageView.image = [self.view imageByRenderingView];
    [currentView addSubview:imageView];
    
    return currentView;
}

- (UIView *)getlastView {
    UIView *lastView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 320, 460)];
    
    //nav
    EUNavigationController *nav = (EUNavigationController *)self.navigationController;
    UIImage *bottomImage = [nav.imageNavigationBars lastObject];
    UIImageView *imageNav = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    imageNav.image = bottomImage;
    [lastView addSubview:imageNav];
    
    //view
    UIViewController *bottomView = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 320, 416)];
    imageView.image = [bottomView.view imageByRenderingView];
    [lastView addSubview:imageView];
    
    _lastViewShadow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, lastView.frame.size.width, lastView.frame.size.height)];
    _lastViewShadow.backgroundColor = [UIColor blackColor];
    _lastViewShadow.alpha = 0.5;
    [lastView addSubview:_lastViewShadow];
    

    
    return lastView;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint endLocation = [[touches anyObject] locationInView:self.view];
   // NSLog(@"Move: x:%f y:%f", endLocation.x, endLocation.y);
    
    float moveX = endLocation.x - pointBegan.x;
    NSLog(@"move x is: %f", moveX);
    
    CGRect oldFrame = _currentView.frame;
    oldFrame.origin.x = moveX;
    _currentView.frame = oldFrame;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint endLocation = [[touches anyObject] locationInView:self.view];
    NSLog(@"End: x:%f y:%f", endLocation.x, endLocation.y);
    
    //开始动画
    [UIView animateWithDuration:0.35 animations:^{
        CGRect oldFrame = _currentView.frame;
        oldFrame.origin.x = 320;
        _currentView.frame = oldFrame;
        _lastViewShadow.alpha = 0;
        _lastView.frame = CGRectMake(0, 0, 320, 460);
    } completion:^(BOOL finished) {
//        [_lastView removeFromSuperview];
//        [_currentView removeFromSuperview];
        [_animationBg removeFromSuperview];
        [self.navigationController popViewControllerAnimated:NO];
    }];
}
@end
