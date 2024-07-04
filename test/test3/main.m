//
//  main.m
//  test3
//
//  Created by 龚嘉骏 on 2024/6/19.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    int number;
    
    NSLog(@"请输入一个整数：");

    while (scanf("%d", &number) != 1) {
        NSLog(@"输入错误，请重新输入一个整数：");
        while (getchar() != '\n');
    }
    
    if (number > 0) {
        NSLog(@"输入的数是正数。");
    } else if (number < 0) {
        NSLog(@"输入的数是负数。");
    } else {
        NSLog(@"输入的数是零。");
    }
    
    return 0;
}
