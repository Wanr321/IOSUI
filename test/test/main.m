//
//  main.m
//  test1
//
//  Created by 龚嘉骏 on 2024/6/18.
//

#import <Foundation/Foundation.h>

int add(int, int);


int main(int argc, const char * argv[]) {
    int age = 22;
    BOOL volatile1 = YES;
    volatile1 = false;
    //YES 是 signed char 是 1，true 是 int 定义为 1
    
    NSString *name = @"龚嘉骏";
    char welcomeChars[] = "姓名";
    
    NSLog(@"%s : %10@\n", welcomeChars, name);
    printf("%s : %6d\n", "年龄", age);
    
    int num1 = 10;
    int num2 = 20;
    NSLog(@"%d", add(num1, num2));
    
    NSString *message = @"Hello, World!";
    NSLog(@"%@", message);
    
    return 0;
}

int add(int a, int b){
    return a + b;
}
