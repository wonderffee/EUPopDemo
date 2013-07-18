//
//  EUNavigationController.h
//  PopDemo
//
//  Created by csj on 13-7-18.
//  Copyright (c) 2013年 eu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EUNavigationController : UINavigationController {

}

//除去栈顶的每一级的NavigationBar图片
@property (nonatomic, strong) NSMutableArray *imageNavigationBars;

@end
