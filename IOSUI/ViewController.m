//
//  ViewController.m
//  IOSUI
//
//  Created by 龚嘉骏 on 2024/6/26.
//

#import "ViewController.h"
#import "ViewController/SecondViewController.h"
#import "ViewController/TestViewController.h"

#import "MyUnity/ImageTools.h"

// 类扩展，一种匿名的类别 @interface Person()
@interface ViewController () <UITextFieldDelegate, UITextViewDelegate, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, TestViewControllerDelegate>
@property UIScrollView *scrollView;
@property UIButton *navigateButton; //导航按钮
@property UIButton *testNavigateButton; //导航按钮
@property UITextField *uiTextField;
@property UIImageView *imageView;
@property NSString *currentImageName;
@property UITableView *tableView;
@property NSArray *numbersArray;
@property UICollectionView *collectionView;
@property NSArray *imageNamesArray;

@property SecondViewController *secondVC;
@property (strong)TestViewController *testVC;
@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

#pragma mark 页面滚动
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 3 * self.view.bounds.size.height);
#pragma mark TODO 再给添加一个content view
    [self.view addSubview:self.scrollView];

#pragma mark 导航按钮
    self.navigateButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.navigateButton.frame = CGRectMake(10, 30, 200, 50);
    [self.navigateButton setTitle:@"下一页" forState:UIControlStateNormal];
    [self.navigateButton addTarget:self action:@selector(navigateButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.navigateButton];
    
    self.testNavigateButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.testNavigateButton.frame = CGRectMake(200, 30, 200, 50);
    [self.testNavigateButton setTitle:@"测试页" forState:UIControlStateNormal];
    [self.testNavigateButton addTarget:self action:@selector(testNavigateButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.testNavigateButton];
    
#pragma mark 标签
    UILabel *uiLable = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 300, 100)];
    uiLable.text = @"Hello, World!";
    uiLable.font = [UIFont systemFontOfSize:20];
    uiLable.textColor = [UIColor redColor];
    [self.scrollView addSubview:uiLable];
    
#pragma mark 按钮
    UIButton *uiButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 200, 300, 100)];
    [uiButton setTitle:@"Click Me" forState:UIControlStateNormal];
    uiButton.backgroundColor = [UIColor blueColor];
    [uiButton addTarget:self action:@selector(uiButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:uiButton];
    
#pragma mark 输入行
    self.uiTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 300, 300, 20)];
    self.uiTextField.placeholder = @"请输入姓名";
    self.uiTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.uiTextField.delegate = self;
    [self.scrollView addSubview:self.uiTextField];
#pragma mark 输入提交按钮
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 350, 50, 50)];
    submitButton.backgroundColor = [UIColor greenColor];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setTitle:@"*" forState:UIControlStateHighlighted];
    [submitButton addTarget:self action:@selector(submitButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:submitButton];

#pragma mark 输入框
    UITextView *uiTextView = [[UITextView alloc] initWithFrame:CGRectMake(50, 400, 200, 100)];
    uiTextView.layer.borderWidth = 1.0;
    uiTextView.layer.borderColor = [UIColor grayColor].CGColor;
    uiTextView.delegate = self;
    [self.scrollView addSubview:uiTextView];
    
#pragma mark 图片
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 500, 200, 200)];
    self.imageView.layer.borderWidth = 1.0;
    UIImage *originalImg = [UIImage imageNamed:@"img/01"];
    UIImage *scaledImg = [ImageTools imageWithImage:originalImg scaledToSize:CGSizeMake(100, 100)];
    self.imageView.image = scaledImg;
    self.currentImageName = @"img/01";
    //self.imageView.accessibilityIdentifier = @"img/01";
    //imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.contentMode = UIViewContentModeCenter;
    self.imageView.userInteractionEnabled = YES;
    [self.scrollView addSubview:self.imageView];
    // 图片点击
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapped:)];
    [self.imageView addGestureRecognizer:tapGestureRecognizer];
    
#pragma mark 列表
    self.numbersArray = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(50, 700, 300, 500) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.scrollView addSubview:self.tableView];
    // 列表刷新按钮
    UIButton *refreshButton = [[UIButton alloc] initWithFrame:CGRectMake(250, 600, 50, 50)];
    [refreshButton setTitle:@"刷新" forState:UIControlStateNormal];
    refreshButton.backgroundColor = [UIColor blueColor];
    [refreshButton addTarget:self action:@selector(refreshButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:refreshButton];

#pragma mark 图片集
    self.imageNamesArray = @[@"img/01", @"img/02", @"img/03"];
    //设置布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(100, 100); // 设置 Cell 的大小
    layout.minimumInteritemSpacing = 10; // 设置水平间距
    layout.minimumLineSpacing = 10; // 设置垂直间距
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10); // 设置每个 section 的边距
    // 设置图片集
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(50, 900, 300, 300) collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor yellowColor];
    // 注册viewcell的类别
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.scrollView addSubview:self.collectionView];
}
#pragma mark -

#pragma mark 导航按钮方法
- (void)navigateButtonTapped {
    self.secondVC = [[SecondViewController alloc] init];
    self.secondVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    NSLog(@"导航至第二页");
    [self presentViewController:self.secondVC animated:YES completion:^{}];
    
}

- (void)testNavigateButtonTapped{
    NSLog(@"先创建还是先销毁");
    self.testVC = [[TestViewController alloc] init];
    self.testVC.receivedData = @"主动设置参数";
    
    // 委托传参，设置被
    self.testVC.delegate = self;
    
    NSLog(@"导航至测试页");
    // 这里要先在 Appdelegate 添加 UINavigationController
    NSLog(@"注意一下 nav controller 的对象是不是空了，动态语言就是这点麻烦%@", [self navigationController]);
    [self.navigationController pushViewController:self.testVC animated:YES];
}

- (void)didReceiveData:(NSString *)data {
    // 首先导入委托的协议，然后设置实例委托的对象为自己，在实现方法里就可以设置这些东西了
    NSLog(@"得到了 %@", data);
    self.uiTextField.text = data;
}

#pragma mark 按钮事件
- (void)uiButtonClicked:(UIButton *)sender{
    NSLog(@"按钮被点击");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Button clicked!" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark 输入提交事件
- (void)submitButton:(UIButton *)sender {
    NSString *enteredName = self.uiTextField.text;
    NSLog(@"姓名：%@", enteredName);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:enteredName preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

// 输入完毕返回事件，跟 delegate = self 有关
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder]; // 收起键盘
    return YES;
}

#pragma mark 输入框事件，限制长度
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSUInteger newLength = textView.text.length + text.length - range.length;
    if (newLength <= 20) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark 图片点击事件
- (void)imageViewTapped:(UITapGestureRecognizer *)tapGestureRecognizer {
    NSLog(@"现在是%@", self.currentImageName);
    if ([self.currentImageName isEqualToString:@"img/01"]) {        NSLog(@"切换到图2");
        UIImage *originalImg = [UIImage imageNamed:@"img/02"];
        UIImage *scaledImg = [ImageTools imageWithImage:originalImg scaledToSize:CGSizeMake(100, 100)];
        self.imageView.image = scaledImg;
        self.currentImageName = @"img/02";
    }else{
        NSLog(@"切换到图1");
        UIImage *originalImg = [UIImage imageNamed:@"img/01"];
        UIImage *scaledImg = [ImageTools imageWithImage:originalImg scaledToSize:CGSizeMake(100, 100)];
        self.imageView.image = scaledImg;
        self.currentImageName = @"img/01";
    }

    //self.imageView.image = [UIImage imageNamed:@"img/02"];
}

#pragma mark 列表事件
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.numbersArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // 设置每行显示的数字
    NSString *numberText = self.numbersArray[indexPath.row];
    cell.textLabel.text = numberText;
    
    return cell;
}

#pragma mark  计算平方差

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *selectedNumberText = self.numbersArray[indexPath.row];
    NSInteger selectedNumber = [selectedNumberText integerValue];
    
    NSInteger square = selectedNumber * selectedNumber;
    
    NSLog(@"选了%@ 平方是 %ld", selectedNumberText, (long)square);
    
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark 列表刷新事件
- (void)refreshButtonTapped:(id)sender {
    // 刷新数据，显示数字 11 到 20
    [self refreshNumbersArrayFrom:11 to:20];
    [self.tableView reloadData];
    
    // 滚动到顶部
    [self.tableView setContentOffset:CGPointZero animated:YES];
}
- (void)refreshNumbersArrayFrom:(NSInteger)startNumber to:(NSInteger)endNumber {
    NSMutableArray *newNumbers = [NSMutableArray array];
    for (NSInteger i = startNumber; i <= endNumber; i++) {
        [newNumbers addObject:[NSString stringWithFormat:@"%ld", (long)i]];
    }
    self.numbersArray = [newNumbers copy];
}


#pragma mark 图片集事件

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageNamesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    // 设置单元格的背景视图为图片
    NSString *imageName = self.imageNamesArray[indexPath.item];
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    cell.backgroundView = imageView;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 获取用户点击的图片名称或索引号
    NSString *selectedImageName = self.imageNamesArray[indexPath.item];
    NSLog(@"选中了 %@", selectedImageName);
    
    // 或者，如果需要索引号，可以直接输出 indexPath.item
    // NSLog(@"Selected image index: %ld", (long)indexPath.item);
}
@end
