//
//  NSKVONotifying_LWKOVPerson.m
//  LWTestDemo
//
//  Created by linwei on 2021/3/1.
//

#import "NSKVONotifying_LWKOVPerson.h"

@implementation NSKVONotifying_LWKOVPerson
//runtime动态生成的类 内部实现
- (void)setAge:(int)age{
    _NSSetIntValueAndNotify();
}

- (Class)class{
    return [LWKOVPerson class];
}

- (void)dealloc{
    
}

- (Bool)_isKVOA
{
    return YES;
}

//伪代码
void _NSSetIntValueAndNotify()
{
//    [self willChangeValueForKey:@"age"];
//    [super setAge:age];
//    [self didChangeValueForKey:@"age"]
}
- (void)didChangeValueForKey:(NSString *)key{
//    [oberser observeValueForKeyPath:key ofObject:self change:nil context:nil];    
}
@end
