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
    https://opensource.apple.com/tarballs/objc4
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
        1) instance的isa指向class
        2）class的isa指向meta-class
        3）meta-class的isa指向基类的meta-class
        4）基类的meta-class的isa指向自己
    superclass指向指向:
        1)class的superclass指向父类的class
            如果没有父类，superclass指针指向nil
        2)meta-class的superclass指向父类的meta-class
        3)基类的meta-class的superclass指向基类
 
    3.OC的类信息存放在哪里？
        对象方法，属性，成员变量，协议信息，存放在class对象中。
        类方法，存放在meta-class对象中。
        成员变量的具体值放在实例对象中。
    4.iOS中的 isKindOfClass 和 isMemberOfClass
     BOOL res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
     BOOL res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
     BOOL res3 = [(id)[TestObject class] isKindOfClass:[TestObject class]];
     BOOL res4 = [(id)[TestObject class] isMemberOfClass:[TestObject class]];
    答案：除了第一个是YES，其他三个都是NO。
     + (BOOL)isMemberOfClass:(Class)cls {
         return object_getClass((id)self) == cls;
     }

     - (BOOL)isMemberOfClass:(Class)cls {
         return [self class] == cls;
     }

     + (BOOL)isKindOfClass:(Class)cls {
         for (Class tcls = object_getClass((id)self); tcls; tcls = tcls->super_class) {
             if(tcls == cls) return YES;
         }
         return NO；
     }
     -（BOOL)isKindOfClass:(Class)cls {
         for(Class tcls = [self class]; tcls; tcls = tcls->super_class) {
             if(tcls == cls) return YES;
         }
         return NO;
     }

 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self objcSize];
    [self ocClassify];
}

- (void)objcSize{
    NSObject *obj = [[NSObject alloc]init];
    //获得NSObject 类的实例对象的成员变量所占用的大小 >>>> 8
    //Class's ivar size rounded up to a pointer-size boundary.
    NSLog(@"%zu",class_getInstanceSize([NSObject class]));
    //获取obj所指向的内存大小 >>>>16
    NSLog(@"%zu",malloc_size((__bridge const void *)(obj)));
    
    NSLog(@"%zu",sizeof(struct LWPersion_IMPL));

//    _no 4个 _age 4个 _name 8个 isa 8个 需要24个  分配32个  16的倍数(操作系统分配的内存大小是16的倍数)
//    class_getInstanceS ize 计算对象有多大。malloc_size计算系统分配多大。 sizeof是一个运算符 获取的是编译时候对象的大小。
    LWStudent *student = [[LWStudent alloc]init];
    NSLog(@"%zu",class_getInstanceSize([LWStudent class]));
    NSLog(@"%zu",malloc_size((__bridge const void *)(student)));
}
- (void)ocClassify{
    /*  OC对象的分类
        1.instance对象(实例对象){
            isa
            其他成员变量
        }
        2.class对象（类对象）{
            isa
            superclass
            类的属性信息，类的对象方法信息，类的协议信息，类的成员变量信息(描述信息)
            ...
        }
        3.meta-class（元类对象）{
            isa
            superclass
            类的类方法信息
            ...
     }
     */
    
    // isa & ISA_MASK:
    // LWStudent实例对象的isa：
    // LWStudent 类对象的地址：
    LWStudent *instance = [[LWStudent alloc]init];
    Class studentClass = [LWStudent class];
    Class studentMetaClass = object_getClass(studentClass);
    Class objcMetaClass = object_getClass(studentMetaClass);
    Class objcMetaClass1 = object_getClass(objcMetaClass);
    NSLog(@"%@",[super class]);
    NSLog(@"%p %p %p %p %p",instance,studentClass,studentMetaClass,objcMetaClass,objcMetaClass1);
    NSLog(@"%d %d %d %d",class_isMetaClass(studentClass) ,class_isMetaClass(studentMetaClass),class_isMetaClass(objcMetaClass),class_isMetaClass(objcMetaClass1));
}

@end
