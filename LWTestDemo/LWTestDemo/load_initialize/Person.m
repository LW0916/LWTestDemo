//
//  Person.m
//  load_initialize
//
//  Created by linwei on 2020/7/14.
//  Copyright © 2020 linwei. All rights reserved.
//

#import "Person.h"

@implementation Person

+(void)load {
    NSLog(@"person load 方法");
}
 
+ (void)initialize {
    NSLog(@"person initialize方法");
}

@end
