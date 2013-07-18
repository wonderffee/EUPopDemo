//
//  EUViewController.m
//  PopDemo
//
//  Created by csj on 13-7-18.
//  Copyright (c) 2013年 eu. All rights reserved.
//

#import "EUViewController.h"
#import "EUPopAnimation.h"

@interface EUViewController () {
    EUPopAnimation *_popAnimation;
}
@end

@implementation EUViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         _popAnimation = [[EUPopAnimation alloc ] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


@implementation  EUViewController (PopAnimation)

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint endLocation = [[touches anyObject] locationInView:self.view];
    [_popAnimation begain:endLocation controller:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint endLocation = [[touches anyObject] locationInView:self.view];
    // NSLog(@"Move: x:%f y:%f", endLocation.x, endLocation.y);
    [_popAnimation moved:endLocation];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint endLocation = [[touches anyObject] locationInView:self.view];
    //  NSLog(@"End: x:%f y:%f", endLocation.x, endLocation.y);
    [_popAnimation end:endLocation];
}

@end


