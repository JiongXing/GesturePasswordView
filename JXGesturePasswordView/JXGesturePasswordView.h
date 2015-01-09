//
//  JXGesturePasswordView.h
//  JXGesturePasswordView
//
//  Created by JX on 15/1/9.
//
//

#import <UIKit/UIKit.h>

@protocol JXGesturePasswordViewDelegate;


@interface JXGesturePasswordView : UIView

@property (nonatomic, weak) id<JXGesturePasswordViewDelegate> delegate;

/**
 显示错误的颜色
 */
- (void)showError;

/**
 重置，清空
 */
- (void)reset;

@end


@protocol JXGesturePasswordViewDelegate <NSObject>

- (void)gesturePasswordView:(JXGesturePasswordView *)gesturePasswordView didFinishDrawPassword:(NSString *)password;

@end
