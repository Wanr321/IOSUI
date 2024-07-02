//
//  TestViewController.h
//  IOSUI
//
//  Created by 龚嘉骏 on 2024/7/1.
//

#import <UIKit/UIKit.h>

@protocol TestViewControllerDelegate <NSObject>
- (void)didReceiveData:(NSString *)data;
@end

@interface TestViewController : UIViewController
@property (strong)NSString *receivedData; // 暴露在头文件定义中
@property (weak) id<TestViewControllerDelegate> delegate;
@end

