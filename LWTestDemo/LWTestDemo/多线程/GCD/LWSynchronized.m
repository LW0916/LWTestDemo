//
//  LWSynchronized.m
//  LWTestDemo
//
//  Created by linwei on 2021/7/28.
//

#import "LWSynchronized.h"

@implementation LWSynchronized
- (void)testAddLock{
    @synchronized ([self class]) {
        [super testAddLock];
    }
}

- (void)testSubtractLock{
    @synchronized ([self class]) {
        [super testSubtractLock];
    }
}
@end
