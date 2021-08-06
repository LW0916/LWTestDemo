//
//  LWTimerViewController.m
//  LWTestDemo
//
//  Created by linwei on 2021/8/3.
//

#import "LWTimerViewController.h"
#import "LWProxy.h"
#import "LWProxyTest.h"

@interface LWTimerViewController ()

@property(nonatomic,strong)CADisplayLink *link;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)dispatch_source_t gcdTimer;
@end

@implementation LWTimerViewController

- (void)dealloc{
    NSLog(@"---%s",__func__);
    [self.link invalidate];
    [self.timer invalidate];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self circularReference];
//    [self testProxy];
    [self gcdTimer];
}
//创建gcd定时器
- (void)gcdTimer{
    //队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    //创建定时器
    dispatch_source_t timer= dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //设置时间
    NSTimeInterval start = 2.0;//2s后开始
    NSTimeInterval interval = 1.0;//间隔1s
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, start*NSEC_PER_SEC), interval*NSEC_PER_SEC, 0);
    //设置回调
//    dispatch_source_set_event_handler(timer, ^{
//        NSLog(@"111 %@",[NSThread currentThread]);
//    });
    dispatch_source_set_event_handler_f(timer, timerFire);
    //启动定时器
    dispatch_resume(timer);
    self.gcdTimer = timer;
    //取消定时器
//    dispatch_source_cancel(timer);
}

void timerFire(void *param){
    NSLog(@"222 %@",[NSThread currentThread]);
}

- (void)testProxy{
//    NSProxy 就是用来处理消息转发行为的 方法不存在直接调用 methodSignatureForSelector
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:[LWProxyTest proxyWithTarget:self] selector:@selector(timerTest) userInfo:nil repeats:YES];

}
- (void)circularReference{
    /*
        会循环引用
     */
    //保证使用频率和屏幕刷帧频率一致，大致 60FPS （1秒钟调用60次）
    /*
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(linkTest)];
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTest) userInfo:nil repeats:YES];
    
    */
    //解决循环引用1
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [weakSelf timerTest];
    }];
    
    //解决循环引用2
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:[LWProxy proxyWithTarget:self] selector:@selector(timerTest) userInfo:nil repeats:YES];
    
    self.link = [CADisplayLink displayLinkWithTarget:[LWProxy proxyWithTarget:self] selector:@selector(linkTest)];
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    

    
    // Do any additional setup after loading the view.
}
- (void)linkTest{
    NSLog(@"==%s",__func__);
}
- (void)timerTest{
    NSLog(@"==%s",__func__);
}
@end
