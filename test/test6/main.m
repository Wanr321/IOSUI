//
//  main.m
//  test6
//
//  Created by 龚嘉骏 on 2024/6/19.
//

#import <Foundation/Foundation.h>

float divideby(int dividend, int divisor){
    
    @try {
        if (divisor == 0) {
            NSException *exception = [NSException exceptionWithName:@"DivideByZeroException"
                reason:@"Cannot divide by zero!"
                userInfo:nil];
            @throw exception;
        }
        
        return dividend / divisor;
    }
    @catch (NSException *exception) {
        NSLog(@"%@", [exception reason]);
        return -1;
    }
}

int main(int argc, const char * argv[]) {
    int dividend = 100;
    int divisor;
    for(divisor = -2; divisor <=5; divisor++){
        NSLog(@"%d / %d = %f", dividend, divisor, divideby(dividend, divisor));
    }
    return 0;
}
