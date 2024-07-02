//
//  PopupView.m
//  IOSUI
//
//  Created by 龚嘉骏 on 2024/7/2.
//

#import <Masonry/Masonry.h>
#import "PopupView.h"


@interface PopupView ()

@property (strong) UIView *menuView;
@property (strong) UIButton *option1Button;
@property (strong) UIButton *option2Button;

@end

@implementation PopupView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.menuView = [[UIView alloc] init];
        self.menuView.backgroundColor = [UIColor lightGrayColor];
        self.menuView.hidden = YES;
        [self addSubview:self.menuView];
        
        self.option1Button = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.option1Button setTitle:@"选项一" forState:UIControlStateNormal];
        [self.option1Button addTarget:self action:@selector(option1Tapped) forControlEvents:UIControlEventTouchUpInside];
        [self.menuView addSubview:self.option1Button];
        
        self.option2Button = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.option2Button setTitle:@"选项二" forState:UIControlStateNormal];
        [self.option2Button addTarget:self action:@selector(option2Tapped) forControlEvents:UIControlEventTouchUpInside];
        [self.menuView addSubview:self.option2Button];
        
        [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@120);
        }];
        
        [self.option1Button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.menuView);
            make.height.equalTo(@40);
        }];
        
        [self.option2Button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.option1Button.mas_bottom);
            make.left.right.bottom.equalTo(self.menuView);
            make.height.equalTo(self.option1Button.mas_height);
        }];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self addGestureRecognizer:tapRecognizer];
    }
    return self;
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint tapLocation = [recognizer locationInView:self];
    NSLog(@"点击区域(%f, %f)", tapLocation.x, tapLocation.y);
    if (CGRectContainsPoint(self.menuView.frame, tapLocation)) {
        return; // 如果点击在菜单view内，不跟随移动
    }
    
//    if (!self.menuView.hidden) {
    [self showMenuAtLocation:tapLocation];
//    } else {
//        [self hideMenu];
//    }
}

- (void)showMenuAtLocation:(CGPoint)location {
    CGFloat menuWidth = 120.0;
    CGFloat menuHeight = 80.0; // 2个按钮    
    CGFloat x = location.x;
    CGFloat y = location.y;
    
    if (x + menuWidth > self.bounds.size.width) {
        x = self.bounds.size.width - menuWidth;
    }
    
    if (y + menuHeight > self.bounds.size.height) {
        y = self.bounds.size.height - menuHeight;
    }
    
    [self.menuView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(x));
        make.top.equalTo(@(y));
        make.width.equalTo(@(menuWidth));
        make.height.equalTo(@(menuHeight));
    }];
    
    self.menuView.hidden = NO;
}

- (void)hideMenu {
    self.menuView.hidden = YES;
}

- (void)option1Tapped {
    NSLog(@"点击了选项1");
    [self hideMenu];
}

- (void)option2Tapped {
    NSLog(@"点击了选项2");
    [self hideMenu];
}

@end
