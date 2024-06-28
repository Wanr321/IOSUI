//
//  ImageTools.m
//  IOSUI
//
//  Created by 龚嘉骏 on 2024/6/28.
//

#import "ImageTools.h"

@implementation ImageTools

#pragma mark 工具类
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:newSize];
    UIImage *newImage = [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull context) {
        [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    }];
    return newImage;
}
@end
