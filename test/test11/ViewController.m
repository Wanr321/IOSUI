//
//  ViewController.m
//  test11
//
//  Created by 龚嘉骏 on 2024/7/4.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong) dispatch_semaphore_t semaphore;
@property (strong) UIViewController *testVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Hello, World! %@", [NSThread currentThread]);

    self.testVC = [UIViewController new];
    UIButton *button = [UIButton new];
    button.frame = CGRectMake(100, 300, 200, 50);
    [button setBackgroundColor:[UIColor yellowColor]];
    [button setTitle:@"按钮" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonTask) forControlEvents:UIControlEventTouchUpInside];
    [self.testVC.view addSubview:button];
    
    // [self.navigationController pushViewController:testVC animated:YES];
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    self.semaphore = dispatch_semaphore_create(0);
    
    dispatch_async(globalQueue, ^{
        [self aMethod];
    });
    dispatch_async(dispatch_get_main_queue(), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"等待界面跳转%@", [NSThread currentThread]);
            [self.navigationController pushViewController:self.testVC animated:YES];
        });
    });
    
}

- (void)buttonTask{
    NSLog(@"按钮被点击");
    dispatch_semaphore_signal(self.semaphore);
}

- (void)aMethod{
    NSLog(@"A 方法开始%@", [NSThread currentThread]);
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    
    NSLog(@"A 方法结束%@", [NSThread currentThread]);

}

@end
