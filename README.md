# GesturePasswordView
九宫格手势密码绘制实现

![GesturePassword.gif](https://github.com/JiongXing/GesturePasswordView/raw/master/screenshots/GesturePassword.gif)

### 使用示例
```objc
@interface ViewController () <JXGesturePasswordViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    JXGesturePasswordView *gesturePasswordView = [[JXGesturePasswordView alloc] init];
    gesturePasswordView.center = self.view.center;
    gesturePasswordView.delegate = self;
    [self.view addSubview:gesturePasswordView];
}

- (void)gesturePasswordView:(JXGesturePasswordView *)gesturePasswordView didFinishDrawPassword:(NSString *)password
{
    // 在导航标题显示轨迹
    self.title = password;
    
    // 校验密码
    NSString *successPassword = @"1478";
    NSString *message = nil;
    if (![successPassword isEqualToString:password])
    {
        [gesturePasswordView showError];
        message = [NSString stringWithFormat:@"错误！请依次连接%@", successPassword];
    }
    else
    {
        message = @"正确！";
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
    });
}
```
如果能帮到您，给颗星星吧 ^_^
