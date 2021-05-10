//
//  LWBlockType.m
//  LWTestDemo
//
//  Created by linwei on 2021/3/9.
//

#import "LWBlockType.h"
#import <UIKit/UIKit.h>

int gAge;

typedef void(^LWBlock)(void);

LWBlock myblock(void){
    int age = 10;
    return ^{
        NSLog(@"=====>%d",age);
    };
}

@implementation LWBlockType

- (void)testType{
    /*
    应用程序的内存分配 由低到高   （代码区，静态数据区和动态数据区  全局变量和静态变量分配在静态数据区（全局区） 动态数据区一般就是“堆栈”）
        1、程序区域 text区（存放代码）
        2、数据区域 data区（存放全局变量）
        3、堆 （动态分配内存的 alloc malloc 特点：需要程序员申请 释放内存）
        4、栈 （局部变量 特点：系统自己申请 释放内存）
     */
    int name;
    NSLog(@"数据段 gAge %p",&gAge);
    NSLog(@"栈 name %p",&name);
    NSLog(@"堆 obj %p",[[NSObject alloc]init]);
    NSLog(@"数据段 class %p",[LWBlockType class]);
    NSLog(@"栈 class %p",[NSObject class]);

    /*
        __NSGlobalBlock__ :  没有访问auto变量  __NSGlobalBlock__调用了copy 还是__NSGlobalBlock__
        __NSStackBlock__  ： 访问了auto变量
        __NSMallocBlock__ ：__NSStackBlock__调用了copy
     ARC环境下，编辑器会根据情况自动将栈上的block复制到堆上，比如以下情况：
        1、block作为函数返回的时候。
        2、将block被强指针指向时 __strong。
        3、block作为Cocoa API中方法名含有usingBlock方法参数时。
        4、block作为GCD的方法参数。
     */
    LWBlock block = myblock();//1、block作为函数返回的时候。
    NSLog(@"%@",[block class]);//__NSMallocBlock__
    NSLog(@"%@",[[block class] superclass]);//NSBlock
    NSLog(@"%@",[[[block class] superclass] superclass]);//NSBlock
    NSLog(@"%@",[[[[block class] superclass] superclass] superclass]);//(null)
    
    block();
    void (^block1)(void) = ^(){
        NSLog(@"this is block ");
    };
    NSLog(@"%@",[block1 class]);//__NSGlobalBlock__
    NSLog(@"%@",[[block1 class] superclass]);//NSBlock
    NSLog(@"%@",[[[block1 class] superclass] superclass]);//NSObject
    NSLog(@"%@",[[[[block1 class] superclass] superclass] superclass]);//(null)
    
    int age = 10;
    void (^block2)(void) = ^(){
        NSLog(@"this is block==>%d ",age);
    };// 2、将block被强指针指向时 __strong。
    NSLog(@"%@",[block2 class]);//__NSMallocBlock__
    NSLog(@"%@",[[block2 class] superclass]);//NSBlock
    NSLog(@"%@",[[[block2 class] superclass] superclass]);//NSObject
    NSLog(@"%@",[[[[block2 class] superclass] superclass] superclass]);//(null)
    
    NSLog(@"%@",[ ^(){
        NSLog(@"this is block==>%d ",age);
    } class]);//__NSStackBlock__
    NSLog(@"%@",[[ ^(){
        NSLog(@"this is block==>%d ",age);
    } class] superclass]);//NSBlock
    NSLog(@"%@",[[[ ^(){
        NSLog(@"this is block==>%d ",age);
    } class] superclass] superclass]);//NSObject
    NSLog(@"%@",[[[[ ^(){
        NSLog(@"this is block==>%d ",age);
    } class] superclass] superclass] superclass]);//(null)
    
    NSArray *array = @[];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
    }];//3、block作为Cocoa API中方法名含有usingBlock方法参数时
}

@end
