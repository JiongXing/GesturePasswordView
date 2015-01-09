//
//  ViewController.m
//  JXGesturePasswordView
//
//  Created by JX on 15/1/9.
//
//

#import "ViewController.h"
#import "JXGesturePasswordView.h"

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
