# GesturePasswordView
九宫格手势密码绘制实现

  
### 使用示例
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
			NSLog(@"password:%@", password);
			NSString *successPassword = @"1478";
    
			if (![successPassword isEqualToString:password])
			{
				[gesturePasswordView showError];
			}
		}
### 如果能帮到您，给颗星星吧 ^_^
