//
//  LWBaseLock.m
//  LWTestDemo
//
//  Created by linwei on 2021/7/23.
//

#import "LWBaseLock.h"

@implementation LWBaseLock
- (instancetype)init{
    if (self = [super init]) {
        //初始化
        self.count = 100;
    }
    return self;
}

- (void)testLock{
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        for (int i =0; i<10; i++) {
            NSLog(@"===i=%d currentThread=%@",i,[NSThread currentThread]);
            [self testAddLock];
        }
    });
    dispatch_async(queue, ^{
        for (int j =0; j<10; j++) {
            NSLog(@"===j=%d currentThread=%@",j,[NSThread currentThread]);
            [self testAddLock];
        }
    });
    dispatch_async(queue, ^{
        for (int k =0; k<10; k++) {
            NSLog(@"===k=%d currentThread=%@",k,[NSThread currentThread]);
            [self testSubtractLock];
        }
    });
}

- (void)testAddLock{
    sleep(2);
    NSLog(@"===testAddLock===%d",++self.count);
    
}
- (void)testSubtractLock{
    sleep(2);
    NSLog(@"===testSubtractLock===%d",--self.count);
}

@end
