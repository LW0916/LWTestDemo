//
//  LWMutexLock.m
//  LWTestDemo
//
//  Created by linwei on 2021/7/26.
//

#import "LWMutexLock.h"
#import <pthread.h>
@interface LWMutexLock ()

@property(nonatomic,assign)pthread_mutex_t mutex;

@end

@implementation LWMutexLock

- (instancetype)init{
    if (self = [super init]) {
        //静态初始化
//        pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
        pthread_mutexattr_t attr;
        pthread_mutexattr_init(&attr);
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);//PTHREAD_MUTEX_RECURSIVE：递归锁 允许同一个线程多次加锁。
        //初始化锁
        pthread_mutex_init(&_mutex, &attr);
        //销毁属性
        pthread_mutexattr_destroy(&attr);
        
    }
    return self;
}

- (void)testAddLock{
    //加锁
    pthread_mutex_lock(&_mutex);
    [super testAddLock];
    //解锁
    pthread_mutex_unlock(&_mutex);
}

- (void)testSubtractLock{
    //加锁
    pthread_mutex_lock(&_mutex);
    [super testSubtractLock];
    //解锁
    pthread_mutex_unlock(&_mutex);
}

-(void)dealloc{
    pthread_mutex_destroy(&_mutex);
}
@end
