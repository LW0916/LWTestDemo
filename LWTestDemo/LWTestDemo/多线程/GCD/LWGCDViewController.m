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
    NSLog(@"viewDidLoad开始");
//    [self test0];
//    [self test1];
//    [self test2];
//    [self test3];
//    [self test4];
//    [self test5];
    [self test7];
    NSLog(@"viewDidLoad结束");
    
}
- (void)test0{
    /*
     viewDidLoad开始
     2021-07-14 14:19:36.300910+0800 LWTestDemo[22059:260610] 同步并发队列==11  1  <NSThread: 0x6000038e8200>{number = 1, name = main}
     2021-07-14 14:19:36.300935+0800 LWTestDemo[22059:261109] 异步并发队列11   0  <NSThread: 0x6000038af800>{number = 7, name = (null)}
     2021-07-14 14:19:36.301085+0800 LWTestDemo[22059:260610] 同步并发队列==22  3 <NSThread: 0x6000038e8200>{number = 1, name = main}
     2021-07-14 14:19:36.301103+0800 LWTestDemo[22059:260734] 异步并发队列22  2 <NSThread: 0x6000038f3dc0>{number = 8, name = (null)}
     2021-07-14 14:19:37.302036+0800 LWTestDemo[22059:261109] 异步并串行队列1  4 <NSThread: 0x6000038af800>{number = 7, name = (null)}
     2021-07-14 14:19:38.302508+0800 LWTestDemo[22059:260610] 同步串行队列===11  5 <NSThread: 0x6000038e8200>{number = 1, name = main}
     2021-07-14 14:19:38.302710+0800 LWTestDemo[22059:260610] 中间=====
     2021-07-14 14:19:38.302760+0800 LWTestDemo[22059:261109] 异步并串行队列2  6 <NSThread: 0x6000038af800>{number = 7, name = (null)}
     2021-07-14 14:19:38.302968+0800 LWTestDemo[22059:260610] 同步串行队列===22 7 <NSThread: 0x6000038e8200>{number = 1, name = main}
     2021-07-14 14:19:38.303188+0800 LWTestDemo[22059:260610] 结束
     2021-07-14 14:19:38.303358+0800 LWTestDemo[22059:260610] viewDidLoad结束
     */
    dispatch_queue_t concurrent_queue = dispatch_queue_create("Dan——CONCURRENT", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t serial_queue = dispatch_queue_create("Dan——SERIAL", DISPATCH_QUEUE_SERIAL);

//    for(int i = 0; i < 10; i++){
//        dispatch_async(concurrent_queue, ^{
//            NSLog(@"我开始了：%@ , %@",@(i),[NSThread currentThread]);
//        });
//    }

    /*  队列 FIFO 先进先出 同步主线程  锁死
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"同步主线程  %@",[NSThread currentThread]);
    });
    */
//    dispatch_sync 里面执行当前任务，dispatch_async 不要求立马在当前线程执行 等当前任务执行完在执行。
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
- (void)test1{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"test1异步回到主线程  %@",[NSThread currentThread]);
    });
    NSLog(@"test1");
    
}
- (void)test2{
//    问题：以下代码是在主线程执行的，会不会产生死锁，
//    test2执行任务1    test2执行任务5 test2执行任务2 死锁
    NSLog(@"test2执行任务1");
    dispatch_queue_t serial_queue = dispatch_queue_create("Dan——SERIAL", DISPATCH_QUEUE_SERIAL);
    dispatch_async(serial_queue, ^{
        NSLog(@"test2执行任务2");
        dispatch_sync(serial_queue, ^{
            NSLog(@"test2执行任务3");
        });
        NSLog(@"test2执行任务4");
    });
    NSLog(@"test2执行任务5");
}
- (void)test3{
//    问题：以下代码是在主线程执行的，会不会产生死锁，
//    test3执行任务1    test3执行任务5 test3执行任务2  test3执行任务3  test3执行任务4 不会死锁
    NSLog(@"test3执行任务1");
    dispatch_queue_t serial_queue = dispatch_queue_create("Dan——SERIAL", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t concurrent_queue = dispatch_queue_create("Dan——CONCURRENT", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(serial_queue, ^{
        NSLog(@"test3执行任务2");
        dispatch_sync(concurrent_queue, ^{
            NSLog(@"test3执行任务3");
        });
        NSLog(@"test3执行任务4");
    });
    NSLog(@"test3执行任务5");
}
- (void)test4{
//    问题：以下代码是在主线程执行的，会不会产生死锁， 不会
    NSLog(@"test4执行任务1");
//    dispatch_queue_t serial_queue = dispatch_queue_create("Dan——SERIAL", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t concurrent_queue = dispatch_queue_create("Dan——CONCURRENT", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrent_queue, ^{
        NSLog(@"test4执行任务2");
        dispatch_sync(concurrent_queue, ^{
            NSLog(@"test4执行任务3");
        });
        NSLog(@"test4执行任务4");
    });
    NSLog(@"test4执行任务5");
}

- (void)test5{
    dispatch_queue_t queue1 = dispatch_get_global_queue(0, 0);
    dispatch_queue_t queue2 = dispatch_get_global_queue(0, 0);
    dispatch_queue_t queue3 =   dispatch_queue_create("queue3", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue4 =   dispatch_queue_create("queue4", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue5 =   dispatch_queue_create("queue3", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"test5==>%p %p %p %p %p",queue1,queue2,queue3,queue4,queue5);//est5==>0x10638f2c0 0x10638f2c0 0x600001ba4800 0x600001ba4880 0x600001ba4900
}

- (void)test6{
    NSLog(@"test6=====");
}

- (void)test7{
    //创建队列组
    dispatch_group_t group = dispatch_group_create();
    //创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("myqueue", DISPATCH_QUEUE_CONCURRENT);
    
    //添加异步任务
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i<5; i++) {
            NSLog(@"任务1-%@",[NSThread currentThread]);
        }
    });
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i<5; i++) {
            NSLog(@"任务2-%@",[NSThread currentThread]);
        }
    });
//    //等待前面任务执行完毕后，会自动执行这个任务
//    dispatch_group_notify(group, queue, ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            for (int i = 0; i<5; i++) {
//                NSLog(@"任务3-%@",[NSThread currentThread]);
//            }
//        });
//    });
    
    dispatch_group_notify(group, queue, ^{
        for (int i = 0; i<5; i++) {
            NSLog(@"任务4-%@",[NSThread currentThread]);
        }
    });
    dispatch_group_notify(group, queue, ^{
        for (int i = 0; i<5; i++) {
            NSLog(@"任务5-%@",[NSThread currentThread]);
        }
    });

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //        [self performSelector:@selector(test6) withObject:nil];

    /*
     打印结果
     2021-07-14 14:29:15.192183+0800 LWTestDemo[22713:274628] 3
     2021-07-14 14:29:15.192193+0800 LWTestDemo[22713:274805] 1
     2021-07-14 14:29:15.192379+0800 LWTestDemo[22713:274628] 4
     2021-07-14 14:29:15.192581+0800 LWTestDemo[22713:274805] end
     2021-07-14 14:29:15.192657+0800 LWTestDemo[22713:274628] test6=====
        - (void)performSelector:(SEL)aSelector withObject:(nullable id)anArgument afterDelay:(NSTimeInterval)delay;
        afterDelay  用到了定时器： 往runloop里面添加了一个定时器。
        子线程默认没有runloop 所以子线程test6没有调用。
     所以只有开启runloop才会调用。
        
     */
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        NSLog(@"1");
        [self performSelector:@selector(test6) withObject:nil afterDelay:0.0];
        NSLog(@"end");
        
//        [[NSRunLoop currentRunLoop]addPort:[[NSPort alloc]init] forMode:NSDefaultRunLoopMode];
//        BOOL run= [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        
//        [[NSRunLoop currentRunLoop]run];
    });
    NSLog(@"3");
    [self performSelector:@selector(test6) withObject:nil afterDelay:0.0];
    NSLog(@"4");
    
}
@end
