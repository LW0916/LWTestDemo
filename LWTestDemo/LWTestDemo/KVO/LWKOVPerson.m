//
//  LWKOVPerson.m
//  LWTestDemo
//
//  Created by linwei on 2021/2/26.
//

#import "LWKOVPerson.h"

@implementation LWKOVPerson
- (void)setAge:(int)age{
    _age = age;
    NSLog(@"setAge");
}

- (void)willChangeValueForKey:(NSString *)key{
    [super willChangeValueForKey:key];
    NSLog(@"willChangeValueForKey");
}

- (void)didChangeValueForKey:(NSString *)key{
    NSLog(@"didChangeValueForKey -- begin");
    [super didChangeValueForKey:key];
    NSLog(@"didChangeValueForKey -- end");
}

@end
