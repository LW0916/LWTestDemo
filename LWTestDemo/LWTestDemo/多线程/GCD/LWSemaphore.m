//
//  LWSemaphore.m
//  LWTestDemo
//
//  Created by linwei on 2021/7/28.
//

#import "LWSemaphore.h"

@interface LWSemaphore ()

@property(nonatomic,strong)dispatch_semaphore_t semaphore;
@property(nonatomic,strong)dispatch_semaphore_t semaphoreOne;

@end

@implementation LWSemaphore

- (instancetype)init{
    if (self = [super init]) {
        self.semaphore = dispatch_semaphore_create(5);
        self.semaphoreOne = dispatch_semaphore_create(1);
    }
    return self;
}

- (void)otherTest{
    for(int i =0;i<20;i++){
        [[[NSThread alloc]initWithTarget:self selector:@selector(test) object:nil] start];
    }
}

- (void)test{
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    sleep(2);
    NSLog(@"test==>currentThread=>%@",[NSThread currentThread]);
    dispatch_semaphore_signal(self.semaphore);
}

- (void)testAddLock{
    dispatch_semaphore_wait(self.semaphoreOne, DISPATCH_TIME_FOREVER);
    [super testAddLock];
//    dispatch_semaphore_signal(self.semaphoreOne);
}
- (void)testSubtractLock{
    dispatch_semaphore_wait(self.semaphoreOne, DISPATCH_TIME_FOREVER);
    [super testSubtractLock];
//    dispatch_semaphore_signal(self.semaphoreOne);
}
-(void)touchTest{
    dispatch_semaphore_signal(self.semaphoreOne);
}
@end
