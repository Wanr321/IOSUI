//
//  BannerCollectionViewCell.m
//  IOSUI
//
//  Created by 龚嘉骏 on 2024/6/28.
//
#import <Masonry/Masonry.h>
#import "BannerCollectionViewCell.h"

@implementation BannerCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.imageView];
        
        self.textLabel = [[UILabel alloc] init];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5]; //透明度背景
        self.textLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.textLabel];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.contentView);
            make.height.equalTo(self.contentView.mas_height).multipliedBy(0.8);
        }];
        
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.top.equalTo(self.imageView.mas_bottom);
        }];
    }
    return self;
}
@end
