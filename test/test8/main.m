//
//  main.m
//  test8
//
//  Created by 龚嘉骏 on 2024/7/4.
//

#import <Foundation/Foundation.h>

void task(void);

int main(int argc, const char * argv[]) {
   //@autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        dispatch_queue_t serialQue;
        // dispatch_queue_create("q1", NULL);
        serialQue = dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL);
        dispatch_queue_t concurrentQue = dispatch_queue_create("concurrent", DISPATCH_QUEUE_CONCURRENT);
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
       
        void (^block)(void) = ^(void){
        //dispatch_block_t block = ^(void){
           NSLog(@"执行了这个任务%@", [NSThread currentThread]);
        };
       
        //dispatch_async(serialQue, block);
        dispatch_async(concurrentQue, block);

        NSLog(@"end   ==== >>: %@",[NSThread currentThread]);

    //}
    return 0;
}

