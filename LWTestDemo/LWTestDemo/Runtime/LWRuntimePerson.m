//
//  LWRuntimePerson.m
//  LWTestDemo
//
//  Created by linwei on 2021/5/19.
//

#import "LWRuntimePerson.h"
#import <objc/runtime.h>


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
+(BOOL)resolveClassMethod:(SEL)sel{
    NSLog(@"resolveInstanceMethod===%@",NSStringFromSelector(sel));
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
@end
