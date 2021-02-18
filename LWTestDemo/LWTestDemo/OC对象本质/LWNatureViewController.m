//
//  LWNatureViewController.m
//  LWTestDemo
//
//  Created by linwei on 2021/1/5.
//

#import "LWNatureViewController.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>
#import "LWStudent.h"


struct NSObject_IMPL
{
    Class isa;
};

struct LWPersion_IMPL
{
    struct NSObject_IMPL NSOBJECT_IVARS;//8
    int _age;//4
    int _height;//4
    int _no;//4
};//24

@interface LWNatureViewController ()

@end

@implementation LWNatureViewController
/*
   OC源码地址 opensource.apple.com/tarballs
    OC-> C,C++ -> 汇编 ->机器语言
    生成c++文件
    xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc main.m -o main-arm64.cpp   
 
 NSObject_implementation
 struct NSObject_IMPL{
     Class isa; //64位占8个字节 32位占4个字节
 };

 @interface NSObject <NSObject> {
     Class isa  OBJC_ISA_AVAILABILITY;
 }
 
 */
/*
    面试题：
    1.一个NSObject占用了多少个字节?
        系统分配了16个字节给NSObject对象（可以通过malloc_size函数获得）
        但NSObject对象内部使用了8个字节空间（64位环境下 通过class_getInstanceSize函数获得）
        FC requires all objects be at least 16bytes
 
    2.对象的isa指针指向哪里？
 
    3.OC的类信息存放在哪里？
     
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    NSObject *obj = [[NSObject alloc]init];
    //获得NSObject 类的实例对象的成员变量所占用的大小 >>>> 8
    //Class's ivar size rounded up to a pointer-size boundary.
    NSLog(@"%zu",class_getInstanceSize([NSObject class]));
    //获取obj所指向的内存大小 >>>>16
    NSLog(@"%zu",malloc_size((__bridge const void *)(obj)));
    
    NSLog(@"%zu",sizeof(struct LWPersion_IMPL));

//    _no 4个 _age 4个 _name 8个 isa 8个 需要24个  分配32个  16的倍数(操作系统分配的内存大小是16的倍数)
//    class_getInstanceSize 计算对象有多大。malloc_size计算系统分配多大。 sizeof是一个运算符 获取的是编译时候对象的大小。
    LWStudent *student = [[LWStudent alloc]init];
    NSLog(@"%zu",class_getInstanceSize([LWStudent class]));
    NSLog(@"%zu",malloc_size((__bridge const void *)(student)));

    
    /*  OC对象的分类
        1.instance对象(实例对象){
            isa
            其他成员变量
        }
        2.class对象（类对象）{
            isa
            superclass
            属性，对象方法，协议，成员变量
            ...
        }
        3.meta-class（元类对象）{
            isa
            superclass
            类方法
            ...
     }
     */
    LWStudent *instance = [[LWStudent alloc]init];
    Class studentClass = [LWStudent class];
    Class studentMetaClass = object_getClass(studentClass);
    NSLog(@"%p %p %p",instance,studentClass,studentMetaClass);
    
}

@end
