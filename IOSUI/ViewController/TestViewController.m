//
//  TestViewController.m
//  IOSUI
//
//  Created by 龚嘉骏 on 2024/7/1.
//
#import <Masonry/Masonry.h>
#import "TestViewController.h"
#import "../View/PopupView.h"

@interface TestViewController ()
@property (strong) PopupView *popupView;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //UIView *testView = [UIView new];
    self.view.backgroundColor = [UIColor whiteColor];

    UILabel *uiLabel = [[UILabel alloc] init];
    uiLabel.text = [NSString stringWithFormat:@"你好, %@", self.receivedData]; //使用创建子视图的参数
    uiLabel.textColor = [UIColor blueColor];
    [self.view addSubview:uiLabel];
    
    [uiLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_bottom).multipliedBy(0.4);
    }];
    
    self.popupView = [[PopupView alloc] init];
    self.popupView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.popupView];
    
    [self.popupView mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_bottom).multipliedBy(0.6);
    }];
    
    UITapGestureRecognizer *outsideTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleOutsideTap:)];
    [self.view addGestureRecognizer:outsideTapRecognizer];
    
}
- (void)dealloc{
    NSLog(@"销毁了哦");
}

// 当界面消失时进行参数传递
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([self.delegate respondsToSelector:@selector(didReceiveData:)]) {
        [self.delegate didReceiveData:@"来自二楼的委托传参"];
    }
}

- (void)handleOutsideTap:(UITapGestureRecognizer *)recognizer {
    [self.popupView hideMenu];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
