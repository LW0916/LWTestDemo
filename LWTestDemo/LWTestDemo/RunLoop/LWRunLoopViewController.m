//
//  LWRunLoopViewController.m
//  LWTestDemo
//
//  Created by linwei on 2021/6/29.
//

#import "LWRunLoopViewController.h"

@interface LWRunLoopViewController ()
{
    CFRunLoopObserverRef observer ;
}
@end

@implementation LWRunLoopViewController

-(void)dealloc{
    CFRunLoopRemoveObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
    CFRelease(observer);
    observer = NULL;
}
 
- (void)viewDidLoad{
    [super viewDidLoad];
    /*
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    NSRunLoop *mainRunLoop = [NSRunLoop mainRunLoop];
    CFRunLoopRef ref = CFRunLoopGetCurrent();
    CFRunLoopRef mainrRef = CFRunLoopGetMain();
     UITrackingRunLoopMode
     kCFRunLoopDefaultMode
    */
    NSLog(@"currentRunLoop=>%p mainRunLoop=>%p",CFRunLoopGetCurrent(),CFRunLoopGetMain());
    NSLog(@"currentRunLoop=>%p mainRunLoop=>%p mainRunLoop=%@",[NSRunLoop currentRunLoop],[NSRunLoop mainRunLoop],[NSRunLoop mainRunLoop]);
    NSLog(@"mainRunLoop=>%@",[NSRunLoop mainRunLoop]);
    [self startObserver];

}

- (void)startObserver{
    // 注册RunLoop状态观察
    CFRunLoopObserverContext context = {0,(__bridge void*)self,NULL,NULL};
    observer = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                       kCFRunLoopAllActivities,
                                       YES,
                                       0,
                                       &runLoopObserverCallBack,
                                       &context);
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
}

 void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){

    /* Run Loop Observer Activities */
//    typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
//        kCFRunLoopEntry = (1UL << 0),
//        kCFRunLoopBeforeTimers = (1UL << 1),
//        kCFRunLoopBeforeSources = (1UL << 2),
//        kCFRunLoopBeforeWaiting = (1UL << 5),
//        kCFRunLoopAfterWaiting = (1UL << 6),
//        kCFRunLoopExit = (1UL << 7),
//        kCFRunLoopAllActivities = 0x0FFFFFFFU
//    };
    
    if (activity == kCFRunLoopEntry) {
        NSLog(@"runLoopObserverCallBack -->%@--->%@",@"进入RunLoop循环(这里其实还没进入)",CFRunLoopCopyCurrentMode(CFRunLoopGetCurrent()));
    }else if(activity == kCFRunLoopBeforeTimers){
        NSLog(@"runLoopObserverCallBack -->%@",@" RunLoop 要处理timer了");
    }else if(activity == kCFRunLoopBeforeSources){
        NSLog(@"runLoopObserverCallBack -->%@",@"RunLoop 要处理source了");
    }else if(activity == kCFRunLoopBeforeWaiting){
        NSLog(@"runLoopObserverCallBack -->%@",@"RunLoop 要休眠了");
    }else if(activity == kCFRunLoopAfterWaiting){
        NSLog(@"runLoopObserverCallBack -->%@",@"RunLoop 刚从休眠中唤醒");
    }else if(activity == kCFRunLoopExit){
        NSLog(@"runLoopObserverCallBack -->%@",@"RunLoop 即将退出RunLoop");
    }else if(activity == kCFRunLoopAllActivities){
        NSLog(@"runLoopObserverCallBack -->%@-->%@",@"RunLoop kCFRunLoopAllActivities",CFRunLoopCopyCurrentMode(CFRunLoopGetCurrent()));
    }
   
}

@end
