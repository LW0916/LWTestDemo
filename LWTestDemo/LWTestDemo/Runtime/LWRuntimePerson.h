//
//  LWRuntimePerson.h
//  LWTestDemo
//
//  Created by linwei on 2021/5/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWRuntimePerson : NSObject

@property(nonatomic,assign,getter=isRich)BOOL rich;
@property(nonatomic,assign,getter=isTall)BOOL tall;
@property(nonatomic,assign,getter=isHandsome)BOOL handsome;

- (void)personTest;
- (void)test;
+ (void)testC;
@end

NS_ASSUME_NONNULL_END
