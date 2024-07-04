//
//  main.m
//  test5
//
//  Created by 龚嘉骏 on 2024/6/19.
//

#import <Foundation/Foundation.h>

@interface Shape : NSObject
-(double) calculateArea;
@end

@interface Circle : Shape
@property (assign) double radius;
-(instancetype) initWithRadius: (double) radius;
@end

@interface Rectangle : Shape
@property (assign) double width;
@property (assign) double height;
-(instancetype)initWithWidth: (double) width Height:(double) height;
@end


int main(int argc, const char * argv[]) {
    double radius = 1;
    Circle *circle = [[Circle alloc] initWithRadius:radius];
    NSLog(@"半径为%lf的圆的面积是：%lf", radius, [circle calculateArea]);
    
    double width = 2;
    double height = 3;
    Rectangle *rectangle = [[Rectangle alloc] initWithWidth:width Height:height];
    NSLog(@"宽为%lf，高为%lf的矩型的面积是：%lf", width, height, [rectangle calculateArea]);
    
    return 0;
}

@implementation Shape
-(double)calculateArea{
    return 0.0;
}
@end

@implementation Circle
-(instancetype)initWithRadius:(double)radius{
    self = [super init];
    if (self) {
        self.radius = radius;
    }
    return self;
}
-(double)calculateArea{
    return M_PI * self.radius * self.radius;
}
@end

@implementation Rectangle
-(instancetype)initWithWidth:(double)width Height:(double)height{
    self = [super init];
    if (self) {
        self.width = width;
        self.height = height;
    }
        return self;
}
- (double)calculateArea{
    return self.width * self.height;
}

@end
