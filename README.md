# GesturePasswordView
九宫格手势密码绘制实现

# 创建
JXGesturePasswordView *gesturePasswordView = [[JXGesturePasswordView alloc] init];

# 设置代理
gesturePasswordView.delegate = self;

# 连线完成后回调此方法，传入所连的轨迹序列
- (void)gesturePasswordView:(JXGesturePasswordView *)gesturePasswordView didFinishDrawPassword:(NSString *)password;

# 设置错误颜色(图片)
[gesturePasswordView showError];

# 如果能帮到您，给颗星星吧 ^_^
