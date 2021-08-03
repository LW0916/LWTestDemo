//
//  LWLock.m
//  LWTestDemo
//
//  Created by linwei on 2021/7/20.
//

#import "LWOSSpinLock.h"
#import <libkern/OSAtomic.h>

@interface LWOSSpinLock ()

@property(nonatomic,assign)OSSpinLock lock;
@end

@implementation LWOSSpinLock

- (instancetype)init{
    if (self = [super init]) {
        //初始化
        self.lock = OS_SPINLOCK_INIT;
    }
    return self;
}
/*
    OSSpinLock 叫做“自旋锁”，等待锁的线程会处于忙等（busy-wait）状态，一直占用着CPU资源
    目前已经不安全了，可能会出现优先级反转问题。
    
 */
 
- (void)testAddLock{
    //加锁
    OSSpinLockLock(&_lock);
    [super testAddLock];
    //解锁
    OSSpinLockUnlock(&_lock);
}
- (void)testSubtractLock{
    //加锁
    OSSpinLockLock(&_lock);
    [super testSubtractLock];
    //解锁
    OSSpinLockUnlock(&_lock);
}


@end
