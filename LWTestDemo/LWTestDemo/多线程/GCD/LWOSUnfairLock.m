//
//  LWOSUnfairLock.m
//  LWTestDemo
//
//  Created by linwei on 2021/7/26.
//

#import "LWOSUnfairLock.h"
#import <os/lock.h>

@interface LWOSUnfairLock ()

@property(nonatomic,assign)os_unfair_lock lock;

@end

@implementation LWOSUnfairLock

- (instancetype)init{
    if (self = [super init]) {
        //初始化
        self.lock = OS_UNFAIR_LOCK_INIT;
    }
    return self;
}

-  (void)testAddLock{
   //加锁
    os_unfair_lock_lock(&_lock);
   [super testAddLock];
   //解锁
    os_unfair_lock_unlock(&_lock);
}
- (void)testSubtractLock{
   //加锁
    os_unfair_lock_lock(&_lock);
   [super testSubtractLock];
   //解锁
    os_unfair_lock_unlock(&_lock);
  
}

@end
