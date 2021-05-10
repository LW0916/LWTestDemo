//
//  LWBlockPerson.h
//  LWTestDemo
//
//  Created by linwei on 2021/5/8.
//

#import <Foundation/Foundation.h>
typedef void(^LWBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface LWBlockPerson : NSObject

@property(nonatomic,copy)LWBlock block;
@property (nonatomic,assign)int age;

@end

NS_ASSUME_NONNULL_END
