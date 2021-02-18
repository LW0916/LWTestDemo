//
//  Student+test.m
//  load_initialize
//
//  Created by linwei on 2020/7/14.
//  Copyright © 2020 linwei. All rights reserved.
//

#import "Student+test.h"

@implementation Student (test)
+(void)load {
    NSLog(@"Student+test load 方法");
}
 
+ (void)initialize {
    NSLog(@"Student+test initialize方法");
}
@end
