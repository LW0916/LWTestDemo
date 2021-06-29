//
//  LWRuntimeAPI.m
//  LWTestDemo
//
//  Created by linwei on 2021/6/24.
//

#import "LWRuntimeAPI.h"
#import <objc/runtime.h>
#import "LWRuntimePerson.h"

@implementation LWRuntimeAPI

void run(id self,SEL _cmd){
    NSLog(@"---run----%@  -- %@",self,NSStringFromSelector(_cmd));
}

- (void)test{
    //创建类
    Class newClass = objc_allocateClassPair([NSObject class], "LWDog", 0);
    
    //添加成员变量不能放到注册类后面 因为成员变量是只读的 不能拿已经存在的类添加成员变量。
    class_addIvar(newClass, "_age", 4, 1, @encode(int));
    class_addIvar(newClass, "_weight", 4, 1, @encode(int));
    
    class_addMethod(newClass,@selector(run), (IMP)run, "v@:");
    //注册类
    objc_registerClassPair(newClass);
    id dog = [[newClass alloc]init];
    [dog setValue:@10 forKey:@"_age"];
    [dog setValue:@50 forKey:@"_weight"];
    [dog run];
    NSLog(@"LWRuntimeAPI=class_getInstanceSize=>>%zd _age===>%@,_weight===>%@",class_getInstanceSize(newClass),[dog valueForKey:@"_age"],[dog valueForKey:@"_weight"]);
    
    Ivar ageIvar = class_getInstanceVariable([newClass class], "_age");
    NSLog(@"ivar_getName==%s ivar_getTypeEncoding==%s",ivar_getName(ageIvar),ivar_getTypeEncoding(ageIvar));
    
    
    // 成员变量的数量
    unsigned int count;
    Ivar *ivars = class_copyIvarList([LWRuntimePerson class], &count);
    for(int i=0;i<count;i++){
        Ivar ivar = ivars[i];
        NSLog(@"%s %s",ivar_getName(ivar),ivar_getTypeEncoding(ivar));
    }
    free(ivars);
    
    //当不需要这个类的时候去销毁
//    objc_disposeClassPair(newClass);
}

@end
