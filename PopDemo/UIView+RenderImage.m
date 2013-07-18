//
//  UIView+RenderImage.m
//  PopDemo
//
//  Created by csj on 13-7-18.
//  Copyright (c) 2013年 eu. All rights reserved.
//

#import "UIView+RenderImage.h"


#import <QuartzCore/QuartzCore.h>


@implementation UIView (RenderImage)

//截图
- (UIImage *)imageByRenderingView {
	CGFloat oldAlpha = self.alpha;
	
	self.alpha = 1;
	UIGraphicsBeginImageContext(self.bounds.size);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	self.alpha = oldAlpha;
	
	return resultingImage;
}
@end
