//
//  LWPermenantThread.h
//  LWTestDemo
//
//  Created by linwei on 2021/7/5.
//

#import <Foundation/Foundation.h>

typedef void(^LWLWPermenantTask)(void);

NS_ASSUME_NONNULL_BEGIN

@interface LWPermenantThread : NSObject

/// 开启一个线程
- (void)run;

/// 在当前这个线程中执行一个任务
- (void)executeTask:(LWLWPermenantTask)task;

/// 结束一个线程
- (void)stop;

@end

NS_ASSUME_NONNULL_END
