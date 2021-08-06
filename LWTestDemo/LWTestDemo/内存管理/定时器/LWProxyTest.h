//
//  LWProxyTest.h
//  LWTestDemo
//
//  Created by linwei on 2021/8/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWProxyTest : NSProxy

+(instancetype)proxyWithTarget:(id)target;

@property(nonatomic,weak)id target;

@end

NS_ASSUME_NONNULL_END
