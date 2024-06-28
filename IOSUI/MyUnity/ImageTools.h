//
//  ImageTools.h
//  IOSUI
//
//  Created by 龚嘉骏 on 2024/6/28.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageTools:NSObject
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
@end
