//
//  LWPerson+Test.m
//  LWTestDemo
//
//  Created by linwei on 2020/12/21.
//

#import "LWPerson+Test.h"
#import <objc/runtime.h>
//  xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc LWPerson+Test.m 
/*
 struct _category_t {
     const char *name;
     struct _class_t *cls;
     const struct _method_list_t *instance_methods;
     const struct _method_list_t *class_methods;
     const struct _protocol_list_t *protocols;
     const struct _prop_list_t *properties;
 };
 */
@implementation LWPerson (Test)
int height_ ;

NSMutableDictionary *dict;//字典方案存在问题 1.内存无法释放 2.线程安全 3.每一个属性就得建一个字段麻烦。

+ (void)load{
    dict = [[NSMutableDictionary alloc]init];
}
-(void)test{
    
}
- (int)age{
    return 10;
}
- (void)setAge:(int)age{
    
}

- (void)setHeight:(int)height{
    height_ = height;
}

- (int)height{
    return height_;
}

- (void)setWeight:(int)weight{
    NSString *key = [NSString stringWithFormat:@"%p",self];
    dict[key] = @(weight);
}
-(int)weight{
    NSString *key = [NSString stringWithFormat:@"%p",self];
    return [dict[key] intValue];
}


/* 产生关联,让某个对象(name)与当前对象的属性(name)产生关联
 参数1: id object :表示给哪个对象添加关联
 参数2: const void *key : 表示: id类型的key值(以后用这个key来获取属性) 属性名
 参数3: id value : 属性值
 参数4: 策略, 是个枚举(点进去,解释很详细) */
- (void)setName:(NSString *)name{
    NSLog(@"@selector(name) == %p,%p,%p", @selector(name), @selector(name), @selector(name));
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)name{
    return  objc_getAssociatedObject(self, _cmd);
}
/*
- (void)setName:(NSString *)name{
    objc_setAssociatedObject(self, @"name", name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)name{
    return  objc_getAssociatedObject(self, @"name");
}
 */
/*
static const void *LWNameKey = &LWNameKey;
- (void)setName:(NSString *)name{
    objc_setAssociatedObject(self, LWNameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)name{
    return  objc_getAssociatedObject(self, LWNameKey);
}
 */
/*
static const char LWNameKey;
- (void)setName:(NSString *)name{
    objc_setAssociatedObject(self, &LWNameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)name{
    return  objc_getAssociatedObject(self,&LWNameKey);
}
 */
@end
