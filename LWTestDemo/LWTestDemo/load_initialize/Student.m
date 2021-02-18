//
//  Student.m
//  load_initialize
//
//  Created by linwei on 2020/7/14.
//  Copyright © 2020 linwei. All rights reserved.
//

#import "Student.h"

@implementation Student
+(void)load {
    NSLog(@"Student load 方法");
}
 
+ (void)initialize {
    NSLog(@"Student initialize方法");
}
@end
