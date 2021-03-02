//
//  LWKVCDog.m
//  LWTestDemo
//
//  Created by linwei on 2021/3/2.
//

#import "LWKVCDog.h"

@implementation LWKVCDog

- (void)setNilValueForKey:(NSString *)key{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@ value=%@ key=%@",NSStringFromSelector(_cmd),value,key);
}

- (nullable id)valueForUndefinedKey:(NSString *)key{
    NSLog(@"%@  key=%@",NSStringFromSelector(_cmd),key);
    return @"tempValue";
}

@end
