//
//  LWNSLock.m
//  LWTestDemo
//
//  Created by linwei on 2021/7/27.
//

#import "LWNSLock.h"

@interface LWNSLock ()

@property(nonatomic,strong)NSLock *lock;

@end

@implementation LWNSLock
- (instancetype)init{
    if (self = [super init]) {
        //初始化
        self.lock = [[NSLock alloc]init];
        
    }
    return self;
}

- (void)testAddLock{
    //加锁
    [self.lock lock];
    [super testAddLock];
    //解锁
    [self.lock unlock];
}
- (void)testSubtractLock{
    [self.lock lock];
    //加锁
    [super testSubtractLock];
    //解锁
    [self.lock unlock];
}

@end
