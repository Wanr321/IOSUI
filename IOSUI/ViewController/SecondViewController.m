//
//  SecondViewController.m
//  IOSUI
//
//  Created by 龚嘉骏 on 2024/6/27.
//
#import <Masonry/Masonry.h>
#import "SecondViewController.h"
#import "../View/BannerView.h"

@interface SecondViewController ()
//@property (nonatomic, strong) UIView *bannerView;
@property (strong)BannerView *adView;
@property (nonatomic, strong) UIButton *backButton;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray<UIImage *> *images = @[[UIImage imageNamed:@"ad/01"], [UIImage imageNamed:@"ad/02"], [UIImage imageNamed:@"ad/03"]];
    NSArray<NSString *> *texts = @[@"Text 1", @"Text 2", @"Text 3"];
    
    self.adView = [[BannerView alloc] initWithImages:images texts:texts];
    //[self.view addSubview:self.bannerView];
    [self.view addSubview:self.adView];
    
    [self.adView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view); // 顶部对齐父视图顶部，左右边距为0
        make.height.equalTo(self.view).multipliedBy(0.4); //高度占视图的40%
    }];
    
    self.backButton = [[UIButton alloc] init];
    [self.backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.backButton.backgroundColor = [UIColor yellowColor];
    [self.backButton setTitle:@"返回" forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-20); // 右边距离父视图右边缘为20点
        make.bottom.equalTo(self.view).offset(-20); // 底部距离父视图底部为20点
        make.width.equalTo(@80); // 宽度为80点
        make.height.equalTo(@40); // 高度为40点
    }];

}

- (void)backButtonTapped {
    [self dismissViewControllerAnimated:YES completion:nil]; // 返回按钮点击事件，关闭当前视图控制器
}
@end
