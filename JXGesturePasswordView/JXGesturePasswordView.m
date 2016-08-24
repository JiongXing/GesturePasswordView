//
//  JXGesturePasswordView.m
//  JXGesturePasswordView
//
//  Created by JX on 15/1/9.
//
//

#import "JXGesturePasswordView.h"

#pragma mark - 节点Model
@interface JXNodeModel : NSObject

// 数据
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, readonly, assign) CGPoint center;
@property (nonatomic, copy) UIImage *normalImage;
@property (nonatomic, copy) UIImage *selectedImage;
@property (nonatomic, copy) UIImage *errorSelectedImage;

// 操作
@property (nonatomic, readonly, copy) UIImage *currentImage;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) BOOL errored;

@end


@implementation JXNodeModel

- (void)setFrame:(CGRect)frame
{
    _frame = frame;
    
    _center = CGPointMake(frame.origin.x + frame.size.width * 0.5, frame.origin.y + frame.size.height * 0.5);
}

- (void)setNormalImage:(UIImage *)normalImage
{
    _normalImage = normalImage;
    
    // 默认当前图像为普通图像
    _currentImage = normalImage;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    
    if (YES == selected)
    {
        _currentImage = _selectedImage;
    }
    else
    {
        _currentImage = _normalImage;
    }
}

- (void)setErrored:(BOOL)errored
{
    _errored = errored;
    
    if (YES == errored)
    {
        _currentImage = _errorSelectedImage;
    }
    else
    {
        _currentImage = _normalImage;
    }
}

@end

#pragma mark - 手势密码绘制View

#define kNodeSize 75
#define kNodeInterval 20

@implementation JXGesturePasswordView
{
    // 九个点
    NSMutableArray *_nodes;
    
    // 线条
    CGColorRef _lineColor;
    
    // 记录选中
    NSMutableArray *_selectedNodes;
    NSMutableString *_password;
    
    // 尾巴
    CGPoint _tail;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    CGFloat size = kNodeSize * 3 + kNodeInterval * 2;
    frame.size = CGSizeMake(size, size);
    
    self = [super initWithFrame:frame];
    if (nil == self) return nil;
    
    self.backgroundColor = [UIColor whiteColor];
    
    /*
     线
     */
    _lineColor = [UIColor colorWithRed:63/255.0 green:166/255.0 blue:18/255.0 alpha:1.0].CGColor;
    
    /*
     九个点
     */
    _nodes = [NSMutableArray arrayWithCapacity:9];
    NSInteger index = 0;
    for (NSInteger row = 0; row < 3; row ++)
    {
        for (NSInteger col = 0; col < 3; col ++)
        {
            CGRect frame = CGRectMake(col * (kNodeSize + kNodeInterval), row * (kNodeSize + kNodeInterval), kNodeSize, kNodeSize);
            JXNodeModel *node = [[JXNodeModel alloc] init];
            node.frame = frame;
            node.normalImage = [UIImage imageNamed:@"密码1"];
            
            node.selectedImage = [UIImage imageNamed:@"密码2"];
            node.errorSelectedImage = [UIImage imageNamed:@"密码3"];
            node.index = index + 1;
            
            [_nodes addObject:node];
            
            index ++;
        }
    }
    _selectedNodes = [NSMutableArray array];
    
    return self;
}

- (void)showError
{
    for (JXNodeModel *node in _selectedNodes)
    {
        node.errored = YES;
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    /*
     点间连线
     */
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 63/255.0, 166/255.0, 18/255.0, 1.0);
    CGContextSetLineWidth(context, 3);
    
    BOOL lineDrawBegan = NO;
    for (JXNodeModel *node in _selectedNodes)
    {
        if (NO == lineDrawBegan)
        {
            CGContextMoveToPoint(context, node.center.x, node.center.y);
            lineDrawBegan = YES;
        }
        else
        {
            CGContextAddLineToPoint(context, node.center.x, node.center.y);
        }
    }
    
    /*
     尾巴
     */
    if (YES == lineDrawBegan)
    {
        CGContextAddLineToPoint(context, _tail.x, _tail.y);
    }
    
    CGContextStrokePath(context);
    
    /*
     节点
     */
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    for (NSInteger index = 0; index < _nodes.count; index ++)
    {
        JXNodeModel *node = _nodes[index];
        
        CGContextFillEllipseInRect(context, node.frame);
        [node.currentImage drawInRect:node.frame];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint movePoint = [touch locationInView:self];
    
    // 是否进入某个点范围
    for (JXNodeModel *node in _nodes)
    {
        if (YES == node.selected) continue;
        
        if (CGRectContainsPoint(node.frame, movePoint))
        {
            node.selected = YES;
            [_selectedNodes addObject:node];
        }
    }
    
    _tail = movePoint;
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.userInteractionEnabled = NO;
    
    // 记录所连的点
    _password = [NSMutableString string];
    for (JXNodeModel *node in _selectedNodes)
    {
        [_password appendFormat:@"%@", @(node.index)];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(gesturePasswordView:didFinishDrawPassword:)])
    {
        [_delegate gesturePasswordView:self didFinishDrawPassword:_password];
    }
    
    [self performSelector:@selector(reset) withObject:nil afterDelay:0.25];
}

- (void)reset
{
    // 清空
    [_selectedNodes removeAllObjects];
    
    for (JXNodeModel *node in _nodes)
    {
        node.selected = NO;
    }
    
    [self setNeedsDisplay];
    
    self.userInteractionEnabled = YES;
}


@end
