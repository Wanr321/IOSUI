//
//  BannerViewController.m
//  IOSUI
//
//  Created by 龚嘉骏 on 2024/6/27.
//
#import <Masonry/Masonry.h>
#import "BannerView.h"
#import "BannerCollectionViewCell.h"

@interface BannerView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property UICollectionView *collectionView;
@property NSArray<UIImage *> *images;
@property NSArray<NSString *> *texts;
@property NSTimer *timer;
@property NSInteger currentIndex;


@end


@implementation BannerView

- (instancetype)initWithImages:(NSArray<UIImage *> *)images texts:(NSArray<NSString *> *)texts {
    if (self = [super initWithFrame:CGRectZero]) {
        self.images = images;
        self.texts = texts;
        self.currentIndex = 0;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 200);

        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        self.collectionView.pagingEnabled = YES;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.showsHorizontalScrollIndicator = YES; // 底部导航条
        [self.collectionView registerClass:[BannerCollectionViewCell class] forCellWithReuseIdentifier:@"BannerCell"];
        
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        //定时轮播
        [self startTimer];
    }
    return self;
}

- (void)startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(scrollToNext) userInfo:nil repeats:YES];
}

// 轮播到下一张
- (void)scrollToNext {
    self.currentIndex = (self.currentIndex + 1) % self.images.count;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BannerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BannerCell" forIndexPath:indexPath];
    cell.imageView.image = self.images[indexPath.item];
    cell.textLabel.text = self.texts[indexPath.item];
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startTimer];
}
@end
