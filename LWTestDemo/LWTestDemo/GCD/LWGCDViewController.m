//
//  LWGCDViewController.m
//  LWTestDemo
//
//  Created by linwei on 2020/12/15.
//

#import "LWGCDViewController.h"

@interface LWGCDViewController ()

@end

@implementation LWGCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_queue_t concurrent_queue = dispatch_queue_create("Dan——CONCURRENT", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t serial_queue = dispatch_queue_create("Dan——SERIAL", DISPATCH_QUEUE_SERIAL);

//    for(int i = 0; i < 10; i++){
//        dispatch_async(concurrent_queue, ^{
//            NSLog(@"我开始了：%@ , %@",@(i),[NSThread currentThread]);
//        });
//    }
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"异步回到主线程  %@",[NSThread currentThread]);
    });
    
    dispatch_async(concurrent_queue, ^{
        NSLog(@"异步并发队列11   0  %@",[NSThread currentThread]);
    });
    dispatch_sync(concurrent_queue, ^{
        NSLog(@"同步并发队列==11  1  %@",[NSThread currentThread]);
    });
    dispatch_async(concurrent_queue, ^{
        NSLog(@"异步并发队列22  2 %@",[NSThread currentThread]);
    });
    dispatch_sync(concurrent_queue, ^{
        NSLog(@"同步并发队列==22  3 %@",[NSThread currentThread]);
    });

    
    dispatch_async(serial_queue, ^{
        sleep(1);
        NSLog(@"异步并串行队列1  4 %@",[NSThread currentThread]);
    });
    dispatch_sync(serial_queue, ^{
        sleep(1);
        NSLog(@"同步串行队列===11  5 %@",[NSThread currentThread]);
    });
    dispatch_async(serial_queue, ^{
        NSLog(@"异步并串行队列2  6 %@",[NSThread currentThread]);
    });
    NSLog(@"中间=====");
    dispatch_sync(serial_queue, ^{
        NSLog(@"同步串行队列===22 7 %@",[NSThread currentThread]);
    });
    dispatch_async(serial_queue, ^{
        sleep(1);
        NSLog(@"异步并串行队列2  88 %@",[NSThread currentThread]);
    });
    NSLog(@"结束");
}

@end
