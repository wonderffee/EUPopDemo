//
//  EUPopAnimation.h
//  PopDemo
//
//  Created by csj on 13-7-18.
//  Copyright (c) 2013年 eu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EUPopAnimation : NSObject {

}

- (void)begain:(CGPoint)point controller:(UIViewController *)controller;
- (void)moved:(CGPoint)point;
- (void)end:(CGPoint)point;
@end
