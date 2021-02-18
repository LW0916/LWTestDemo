//
//  LWCategoryViewController.m
//  LWTestDemo
//
//  Created by linwei on 2020/12/21.
//


#import "LWCategoryViewController.h"
#import "LWPerson.h"
#import "LWPerson+Test.h"
#import <objc/runtime.h>

@interface LWCategoryViewController ()

@end
/*
    isa指针
     1.instance 的isa指向class
     当调用对象方法时，通过instance的isa指针找到class ，最后找到对象方法的实现调用。
     2.class 的isa指向meta-class
     当调用类对象时，通过class的isa找到isa找到meta-class，最后找到类方法的实现进行调用
 注意：一个类对象只能有一个，和多少个分类无关。分类的方法依然存在类对象里面。同理类方法也是一样放到元类方法里面的。
    Category的本质：
         1.Category的实现原理，以及Category为什么只能加方法不能加属性。
         2.Category中有load方法吗？load方法是什么时候调用的？load 方法能继承吗？
         3.load、initialize的区别，以及它们在category重写的时候的调用的次序。
 
     struct objc_category {
         char * _Nonnull category_name                            OBJC2_UNAVAILABLE;
         char * _Nonnull class_name                               OBJC2_UNAVAILABLE;
         struct objc_method_list * _Nullable instance_methods     OBJC2_UNAVAILABLE;
         struct objc_method_list * _Nullable class_methods        OBJC2_UNAVAILABLE;
         struct objc_protocol_list * _Nullable protocols          OBJC2_UNAVAILABLE;
     }
    运行时初始化的时候通过dyld 把分类数组中的方法 属性 协议最终放到类对象里面去(类方法放到元类方法里面) 分类方法会在类对象方法的前面。 所以分类方法优先调用
 
 面试题：
 category的实现原理：将分类的方法数据 协议数据 属性数据等放到结构体里面去。将结构体里面的方法列表copy到类方法里面去。
 category为什么只能添加方法不能添加属性：1.结构体里面没有成员变量。2.分类是运行时过程中装载的，类里面成员变量是在编译那一刻就确定好了。
 
 
    
 */
@implementation LWCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LWPerson *p = [[LWPerson alloc]init];
    [p run];
    [p test];
    int age = p.age;
    // Do any additional setup after loading the view.
}


@end
