//
//  LWPerson+Test.h
//  LWTestDemo
//
//  Created by linwei on 2020/12/21.
//

#import "LWPerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface LWPerson (Test)

@property(nonatomic,assign)int age;
//只会声明set get方法 没有实现。 如果调用会crash
// -[LWPerson height]: unrecognized selector sent to instance
@property(nonatomic,assign)int height;

@property(nonatomic,assign)int weight;

@property(nonatomic,copy)NSString *name;

-(void)test;

@end

NS_ASSUME_NONNULL_END
