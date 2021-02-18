//
//  Person+test.m
//  load_initialize
//
//  Created by linwei on 2020/7/14.
//  Copyright © 2020 linwei. All rights reserved.
//

#import "Person+test.h"

@implementation Person (test)

+(void)load {
    NSLog(@"person+test load 方法");
}
 
+ (void)initialize {
    NSLog(@"person+test initialize方法");
}

@end
