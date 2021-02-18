//
//  LWLifeCycleView.m
//  LWTestDemo
//
//  Created by linwei on 2020/12/12.
//

/*
    UIView 的生命周期
    当创建 view 时
     willMoveToSuperview:
     didMoveToSuperview
     willMoveToWindow:
     didMoveToWindow
     layoutSubviews
     drawRect:
    当view销毁时
     willMoveToWindow:
     didMoveToWindow
     willMoveToSuperview:
     didMoveToSuperview
     removeFromSuperview
     dealloc
 
    注意：
     只会执行一次的方法有 removeFromSuperview、dealloc 两个方法，可以在这两个方法中执行释放内存、移除观察者、定时器等。

     willRemoveSubview 是在 dealloc 后面执行的。如果有多个子视图，willRemoveSubview 会循环执行，直到移除所有子视图。

 */

#import "LWLifeCycleView.h"
#import "LWSettingLog.h"


@implementation LWLifeCycleView

+(void)load{
    NSLog(@"");
}
+ (void)initialize{
    NSLog(@"");
}
+(id)allocWithZone:(NSZone *)zone{
    return [super allocWithZone:zone];
    NSLog(@"");
}

- (void)willMoveToSuperview:(nullable UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    NSLog(@"");
}
- (void)willMoveToWindow:(nullable UIWindow *)newWindow{
    [super willMoveToWindow:newWindow];
    NSLog(@"");
}
//这两个方法可以根据参数判断，nil 则为销毁，否则为创建；

- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    NSLog(@"");
}
- (void)didMoveToWindow{
    [super didMoveToWindow];
    NSLog(@"");
    
}
/*这两个方法可以根据 self.superview 判断，nil 则为销毁，否则为创建。
 layoutSubviews 的触发条件

 init 初始化不会触发 layoutSubviews，initWithFrame 初始化时，当 rect 的值不为 CGRectZero 时会触发。
 addSubview 会触发 layoutSubviews。
 设置 view 的 Frame 会触发 layoutSubviews。
 滚动一个 UIScrollView 会触发 layoutSubviews。
 旋转 Screen 会触发父 UIView 上的 layoutSubviews。
 setNeedsLayout，标记为需要重新布局，不立即刷新，在下一轮 runloop 结束前刷新，layoutSubviews 一定会被调用。
 layoutIfNeeded，如果有需要刷新的标记，立即调用 layoutSubviews；如果没有标记，不会调用 layoutSubviews。

*/
- (void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"");
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    NSLog(@"");
}
//指定构造函数
//UIView 有两个 Designated Initializer
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    NSLog(@"");
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    NSLog(@"");
    if (self) {
        
    }
    return self;
}

- (void)removeFromSuperview{
    [super removeFromSuperview];
    NSLog(@"");
}
- (void)willRemoveSubview:(UIView *)subview{
    [super willRemoveSubview:subview];
    NSLog(@"");
}
- (void)dealloc{
    NSLog(@"");
}
@end
