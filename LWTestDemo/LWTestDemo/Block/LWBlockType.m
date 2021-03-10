//
//  LWBlockType.m
//  LWTestDemo
//
//  Created by linwei on 2021/3/9.
//

#import "LWBlockType.h"

typedef void(^LWBlock)(void);

LWBlock myblock(){
    int age = 10;
    return ^{
        NSLog(@"=====>%d",age);
    };
}

@implementation LWBlockType

- (void)testType{
    /*
        __NSGlobalBlock__ :  没有访问auto变量
        __NSStackBlock__  ： 访问了auto变量
        __NSMallocBlock__ ：__NSStackBlock__调用了copy
     ARC环境下，编辑器会根据情况自动将栈上的block复制到堆上，比如以下情况：
        1、block作为函数返回的时候。
        2、将block被强指针指向时 __strong。
     */
    LWBlock block = myblock();
    NSLog(@"%@",[block class]);//__NSMallocBlock__
    NSLog(@"%@",[[block class] superclass]);//__NSMallocBlock
    NSLog(@"%@",[[[block class] superclass] superclass]);//NSBlock
    NSLog(@"%@",[[[[block class] superclass] superclass] superclass]);//NSObject
    
    block();
    void (^block1)(void) = ^(){
        NSLog(@"this is block ");
    };
    NSLog(@"%@",[block1 class]);//__NSGlobalBlock__
    NSLog(@"%@",[[block1 class] superclass]);//__NSGlobalBlock
    NSLog(@"%@",[[[block1 class] superclass] superclass]);//NSBlock
    NSLog(@"%@",[[[[block1 class] superclass] superclass] superclass]);//NSObject
    
    int age = 10;
    void (^block2)(void) = ^(){
        NSLog(@"this is block==>%d ",age);
    };
    NSLog(@"%@",[block2 class]);//__NSMallocBlock__
    NSLog(@"%@",[[block2 class] superclass]);//__NSMallocBlock
    NSLog(@"%@",[[[block2 class] superclass] superclass]);//NSBlock
    NSLog(@"%@",[[[[block2 class] superclass] superclass] superclass]);//NSObject
    
    NSLog(@"%@",[ ^(){
        NSLog(@"this is block==>%d ",age);
    } class]);//__NSStackBlock__
    NSLog(@"%@",[[ ^(){
        NSLog(@"this is block==>%d ",age);
    } class] superclass]);//__NSStackBlock
    NSLog(@"%@",[[[ ^(){
        NSLog(@"this is block==>%d ",age);
    } class] superclass] superclass]);//NSBlock
    NSLog(@"%@",[[[[ ^(){
        NSLog(@"this is block==>%d ",age);
    } class] superclass] superclass] superclass]);//NSObject

}

@end