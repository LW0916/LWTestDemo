//
//  NSArray+LW.m
//  LWTestDemo
//
//  Created by linwei on 2020/12/13.
//

#import "NSArray+LW.h"
#import <objc/runtime.h>

@implementation NSArray (LW)
// method-swizling :load - runtime
// load:时机 + 主动调用
// objc_init - load_images
// load 方法会影响启动速度
+ (void)load{
    // 方法本质 ：消息（消息的接受者，消息主体）
    // __NSArrayI 类簇
    // 方法存在：对象方法和类方法
    // 对象方法存在类里面  类方法存在元类里面 元类的方法在根元类（NSObject 元类） 根元类还是自己
//    Method m1 = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndexedSubscript:));
//    Method m2 = class_getInstanceMethod(self, @selector(lw_objectAtIndexedSubscript:));
//    method_exchangeImplementations(m1, m2);
}

-(id)lw_objectAtIndexedSubscript:(NSUInteger)idx{
    if (idx < self.count) {
        return [self lw_objectAtIndexedSubscript:idx];
    }
    NSLog(@"越界 %lu >= %lu",(unsigned long)idx,(unsigned long)self.count);
    return @"";
}


@end
