//
//  DetailViewController.m
//  PopDemo
//
//  Created by csj on 13-7-18.
//  Copyright (c) 2013年 eu. All rights reserved.
//

#import "DetailViewController.h"
#import "SubDetailViewController.h"

@interface DetailViewController () {
    UIButton *_buttonPush;
}

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Detail View Controller";
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor grayColor];
    
    
    _buttonPush = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _buttonPush.frame  = CGRectMake(10, 10, 70, 37);
    [_buttonPush setTitle:@"push" forState:UIControlStateNormal];
    [_buttonPush addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_buttonPush];
}

- (void)viewDidUnload {
    [super viewDidUnload];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)push{
    [self.navigationController pushViewController:[[SubDetailViewController alloc] initWithNibName:nil bundle:nil] animated:YES];
}

@end



