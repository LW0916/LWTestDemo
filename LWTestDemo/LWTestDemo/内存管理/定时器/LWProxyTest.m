//
//  LWProxyTest.m
//  LWTestDemo
//
//  Created by linwei on 2021/8/3.
//

#import "LWProxyTest.h"

@implementation LWProxyTest

+ (instancetype)proxyWithTarget:(id)target{
    
    LWProxyTest *proxy = [LWProxyTest alloc];
    proxy.target = target;
    return proxy;
}

-(NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    
    return [self.target methodSignatureForSelector:sel];
    
}
-(void)forwardInvocation:(NSInvocation *)invocation{

    [invocation invokeWithTarget:self.target];
    
}
@end
