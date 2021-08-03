//
//  LWBaseLock.h
//  LWTestDemo
//
//  Created by linwei on 2021/7/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWBaseLock : NSObject

@property(nonatomic,assign)int count;

- (void)testLock;

- (void)testAddLock;

- (void)testSubtractLock;

@end

NS_ASSUME_NONNULL_END
