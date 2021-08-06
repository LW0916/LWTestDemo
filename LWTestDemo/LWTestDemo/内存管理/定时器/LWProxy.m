//
//  LWProxy.m
//  LWTestDemo
//
//  Created by linwei on 2021/8/3.
//

#import "LWProxy.h"

@implementation LWProxy
+ (instancetype)proxyWithTarget:(id)target{
    
    LWProxy *proxy = [[LWProxy alloc]init];
    proxy.target = target;
    return proxy;
}
-(id)forwardingTargetForSelector:(SEL)aSelector{
    return  self.target;
}
@end
