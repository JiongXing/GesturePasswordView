# GesturePasswordView
九宫格手势密码绘制实现

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建并居中显示
    JXGesturePasswordView *gesturePasswordView = [[JXGesturePasswordView alloc] init];
    gesturePasswordView.center = self.view.center;
    gesturePasswordView.delegate = self;
    [self.view addSubview:gesturePasswordView];
}

- (void)gesturePasswordView:(JXGesturePasswordView *)gesturePasswordView didFinishDrawPassword:(NSString *)password
{
    NSLog(@"password:%@", password);
    
    NSString *successPassword = @"1478";
    
    if (![successPassword isEqualToString:password])
    {
        // 显示错误的连线颜色(图片)
        [gesturePasswordView showError];
    }
}

如果能帮到您，求星星!

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    // 创建
    JXGesturePasswordView *gesturePasswordView = [[JXGesturePasswordView alloc] init];
    gesturePasswordView.center = self.view.center;

    // 设置代理
    gesturePasswordView.delegate = self;
    [self.view addSubview:gesturePasswordView];
}

- (void)gesturePasswordView:(JXGesturePasswordView *)gesturePasswordView didFinishDrawPassword:(NSString *)password
{
    NSLog(@"password:%@", password);

    NSString *successPassword = @"1478";

    // 取得连线轨迹密码
    if (![successPassword isEqualToString:password])
    {
        // 显示错误的连线颜色(图片)
        [gesturePasswordView showError];
    }
}