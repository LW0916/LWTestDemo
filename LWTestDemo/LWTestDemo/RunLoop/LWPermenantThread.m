//
//  LWPermenantThread.m
//  LWTestDemo
//
//  Created by linwei on 2021/7/5.
//

#import "LWPermenantThread.h"
#import "LWThread.h"

@interface LWPermenantThread ()

@property(nonatomic,strong) LWThread *innerThread;
@property(nonatomic,assign,getter=isStopped) BOOL stopped;

@end

@implementation LWPermenantThread
- (void)dealloc{
    [self stop];
    NSLog(@"%s",__func__);
}
- (instancetype)init{
    if (self = [super init]) {
        __weak typeof(self) weakSelf = self;
        self.innerThread = [[LWThread alloc]initWithBlock:^{
            
            [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc]init] forMode:NSDefaultRunLoopMode];
            
            while (weakSelf && (!weakSelf.isStopped)) {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            }
        }];
    }
    return self;
}
#pragma mark - public methods

- (void)run{
    if (!self.innerThread) return;
    [self.innerThread start];
}

- (void)executeTask:(LWLWPermenantTask)task{
    if (!self.innerThread || !task) return;
    [self performSelector:@selector(__executeTask:) onThread:self.innerThread withObject:task waitUntilDone:NO];
}

- (void)stop{
    if (!self.innerThread) return;
    //    waitUntilDone 是否等待子线程结束再继续
    [self performSelector:@selector(__stop) onThread:self.innerThread withObject:nil waitUntilDone:YES];
}

#pragma mark - private methods

- (void)__stop{
    self.stopped= YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.innerThread = nil;
}

- (void)__executeTask:(LWLWPermenantTask)task{
    task();
}
@end
