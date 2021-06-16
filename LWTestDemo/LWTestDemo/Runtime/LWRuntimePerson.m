//
//  LWRuntimePerson.m
//  LWTestDemo
//
//  Created by linwei on 2021/5/19.
//

#import "LWRuntimePerson.h"
#import <objc/runtime.h>
#import "LWRuntimePersonTest.h"


struct method_t {
    SEL sel;
    char *types;
    IMP imp;
};

@implementation LWRuntimePerson

- (void)personTest{
    NSLog(@"personTest");
}
- (void)other{
    NSLog(@"%s",__func__);
}

+ (void)otherC{
    NSLog(@"%s",__func__);
}

- (void)otherForward{
    NSLog(@"%s",__func__);
}

#pragma mark - 动态方法解析 -
+(BOOL)resolveClassMethod:(SEL)sel{
    NSLog(@"resolveClassMethod===%@",NSStringFromSelector(sel));
    if (sel == @selector(testC)) {
        //获取其他方法
        Method otherMethod = class_getClassMethod(self, @selector(otherC));
        //动态添加test方法的实现
        class_addMethod(object_getClass(self), sel, method_getImplementation(otherMethod), method_getTypeEncoding(otherMethod));
        return YES;
    }
    return  [super resolveClassMethod:sel];
}
+(BOOL)resolveInstanceMethod:(SEL)sel{
    NSLog(@"resolveInstanceMethod===%@",NSStringFromSelector(sel));
    if (sel == @selector(test)) {
        //获取其他方法
        Method otherMethod = class_getInstanceMethod(self, @selector(other));
        //动态添加test方法的实现
        class_addMethod(self, sel, method_getImplementation(otherMethod), method_getTypeEncoding(otherMethod));
        return YES;
    }
    return  [super resolveInstanceMethod:sel];
}

/*
+(BOOL)resolveInstanceMethod:(SEL)sel{
    NSLog(@"resolveInstanceMethod===%@",NSStringFromSelector(sel));
    if (sel == @selector(test)) {
        //获取其他方法
        struct method_t *otherMethod1 = (struct method_t *) class_getInstanceMethod(self, @selector(other));
        NSLog(@"%s %s %p",otherMethod1->sel,otherMethod1->types,otherMethod1->imp);
        //动态添加test方法的实现
        class_addMethod(self, sel, otherMethod1->imp, otherMethod1->types);
        //动态添加test方法的实现
        return YES;
    }
    return  [super resolveInstanceMethod:sel];
}
*/

#pragma mark - 消息转发 -
/*
    类方法调用
 +(id)forwardingTargetForSelector:(SEL)aSelector
 +(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
 +(void)forwardInvocation:(NSInvocation *)anInvocation
*/
-(id)forwardingTargetForSelector:(SEL)aSelector{
    if (aSelector == @selector(testMessage)) {
        return [[LWRuntimePersonTest alloc]init];
    }
    return [super forwardingTargetForSelector:aSelector];
}
//方法签名：返回值类型，参数类型
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if (aSelector == @selector(testForward)) {
        return  [NSMethodSignature signatureWithObjCTypes:"v16@0:8"];;
    }
    return [super methodSignatureForSelector:aSelector];
}
//NSInvocation封装了方法调用，包括：方法调用者，方法，方法参数
//    anInvocation.target;//方法调用者
//    anInvocation.selector;//方法名
//    [anInvocation getArgument:NULL atIndex:0]//方法参数
-(void)forwardInvocation:(NSInvocation *)anInvocation{
//    [anInvocation invokeWithTarget:[[LWRuntimePersonTest alloc]init] ];
}

@end
