//
//  main.m
//  test9
//
//  Created by 龚嘉骏 on 2024/7/4.
//

#import <Foundation/Foundation.h>

void aMethod(dispatch_group_t);
void bMethod(dispatch_group_t);
void cMethod(void);


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World! %@", [NSThread currentThread]);
        
        dispatch_queue_t serialQue = dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL);
        dispatch_queue_t concurrentQue = dispatch_queue_create("concurrent", DISPATCH_QUEUE_CONCURRENT);
        dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

        dispatch_group_t group = dispatch_group_create();
        
        dispatch_async(globalQueue, ^{
            aMethod(group);
        });
        dispatch_async(globalQueue, ^{
            bMethod(group);
        });
        NSLog(@"主线程继续运行");
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            cMethod();
        });

        //手动保持主线程持续运行
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:20]];

    }
    return 0;
}

void aMethod(dispatch_group_t group){
    NSLog(@"A 方法执行%@", [NSThread currentThread]);
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_enter(group);
    
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, (int64_t)3 * NSEC_PER_SEC);
    dispatch_after(delay, globalQueue, ^{
        NSLog(@"A 方法完成");
        dispatch_group_leave(group);
    });
    
}
void bMethod(dispatch_group_t group){
    NSLog(@"B 方法执行%@", [NSThread currentThread]);
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_enter(group);
    
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, (int64_t)10 * NSEC_PER_SEC);
    dispatch_after(delay, globalQueue, ^{
        NSLog(@"B 方法完成");
        dispatch_group_leave(group);
    });
}

void cMethod(void){
    NSLog(@"C 方法执行%@", [NSThread currentThread]);
    if ([NSThread isMainThread]) {
        NSLog(@"好像是在主线程执行哦");
    }
}
