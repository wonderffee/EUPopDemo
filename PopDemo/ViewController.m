//
//  ViewController.m
//  PopDemo
//
//  Created by csj on 13-7-18.
//  Copyright (c) 2013年 eu. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController () {
    UIButton *_buttonPush;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title  =@"List View Controller";
    
    _buttonPush = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _buttonPush.frame  = CGRectMake(10, 10, 70, 30);
    [_buttonPush setTitle:@"push" forState:UIControlStateNormal];
    [_buttonPush addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_buttonPush];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)push {
    DetailViewController *detail = [[DetailViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint endLocation = [[touches anyObject] locationInView:self.view];
    NSLog(@"began: x:%f y:%f", endLocation.x, endLocation.y);
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint endLocation = [[touches anyObject] locationInView:self.view];
    NSLog(@"Move: x:%f y:%f", endLocation.x, endLocation.y);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint endLocation = [[touches anyObject] locationInView:self.view];
    NSLog(@"End: x:%f y:%f", endLocation.x, endLocation.y);
}

@end
