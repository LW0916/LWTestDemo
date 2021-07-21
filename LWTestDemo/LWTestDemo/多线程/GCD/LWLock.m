//
//  LWLock.m
//  LWTestDemo
//
//  Created by linwei on 2021/7/20.
//

#import "LWLock.h"
#import <libkern/OSAtomic.h>

@interface LWLock ()

@end

@implementation LWLock

- (void)testOSSpinLock{
    //初始化
    OSSpinLock lock = OS_SPINLOCK_INIT;
    //加锁
    OSSpinLockLock(&lock);
    NSLog(@"===testOSSpinLock===");
    //解锁
    OSSpinLockUnlock(&lock);
}

@end
