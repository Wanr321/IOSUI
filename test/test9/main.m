//
//  main.m
//  test9
//
//  Created by 龚嘉骏 on 2024/7/4.
//

#import <Foundation/Foundation.h>

//void aMethod(dispatch_queue_t);
void aMethod(void);
void bMethod(void);


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World! %@", [NSThread currentThread]);
        
        dispatch_queue_t serialQue = dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL);
        dispatch_queue_t concurrentQue = dispatch_queue_create("concurrent", DISPATCH_QUEUE_CONCURRENT);
        dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

        dispatch_async(globalQueue, ^{
            aMethod();
        });
        NSLog(@"主线程继续运行");
        //手动保持主线程持续运行
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:10]];

    }
    return 0;
}

void aMethod(void){
    NSLog(@"A 方法执行%@", [NSThread currentThread]);
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, (int64_t)3 * NSEC_PER_SEC);
    dispatch_after(delay, globalQueue, ^{
        bMethod();
    });
    NSLog(@"A 方法继续运行");
}
void bMethod(void){
    NSLog(@"B 方法执行%@", [NSThread currentThread]);

}
