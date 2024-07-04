//
//  main.m
//  test2
//
//  Created by 龚嘉骏 on 2024/6/19.
//

#import <Foundation/Foundation.h>

NSString* isEven(int);

int main(int argc, const char * argv[]) {
    
    for (int i = 0; i <= 10; i++) {
        NSLog(@"%d is %@\n", i, isEven(i));
    }
    return 0;
}

NSString* isEven(int number){
    if (number % 2 == 0) {
        return @"Even";
    }
    return @"Odd";
}
