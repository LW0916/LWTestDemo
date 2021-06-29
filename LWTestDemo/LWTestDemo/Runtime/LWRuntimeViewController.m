//
//  LWRuntimeViewController.m
//  LWTestDemo
//
//  Created by linwei on 2021/5/19.
//

#import "LWRuntimeViewController.h"
#import "LWRuntimePerson.h"
#import "LWRuntimePersonTest.h"
#import "LWRuntimePersonTest2.h"
#import "LWRuntimePersonTest3.h"
#import "LWRuntimePersonCache.h"
#import "LWRuntimeAPI.h"

#import <objc/runtime.h>
#import <objc/message.h>

typedef enum{
    LWOptionsOne = 1<<0,
    LWOptionsTwo = 1<<1,
    LWOptionsThree = 1<<2,
    LWOptionsFour = 1<<3
    
}LWOptions;

@interface LWRuntimeViewController ()

@end

@implementation LWRuntimeViewController
@dynamic age;//提醒编译器不要自动生成setter 和 getter 的实现，不要自动生成成员变量。

- (void)setLWOptions:(LWOptions)options{
    if (options & LWOptionsOne) {
        NSLog(@"包含==LWOptionsOne");
    }
    if (options & LWOptionsTwo) {
        NSLog(@"包含==LWOptionsTwo");
    }
    if (options & LWOptionsThree) {
        NSLog(@"包含==LWOptionsThree");
    }
    if (options & LWOptionsFour) {
        NSLog(@"包含==LWOptionsFour");
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    LWRuntimePerson *person = [[LWRuntimePerson alloc]init];
    person.rich = NO;//1
    person.tall = YES;//1
    person.handsome = NO;//1 
    NSLog(@"----%zd ",class_getInstanceSize([LWRuntimePerson class]));
        
    LWRuntimePersonTest *pTest = [[LWRuntimePersonTest alloc]init];
    pTest.rich = YES;
    pTest.tall = YES;
    pTest.handsome = YES;
    NSLog(@"%d--%d--%d",pTest.isTall,pTest.isRich,pTest.isHandsome);
    
    LWRuntimePersonTest2 *pTest2 = [[LWRuntimePersonTest2 alloc]init];
    pTest2.tall = YES;
    pTest2.rich = NO;    
    pTest2.handsome = NO;
    NSLog(@"%d--%d--%d",pTest2.isTall,pTest2.isRich,pTest2.isHandsome);
    
    
    LWRuntimePersonTest3 *pTest3 = [[LWRuntimePersonTest3 alloc]init];
    pTest3.tall = YES;
    pTest3.rich = NO;
    pTest3.handsome = YES;
    NSLog(@"%d--%d--%d",pTest3.isTall,pTest3.isRich,pTest3.isHandsome);
    
    [self setLWOptions:(LWOptionsOne | LWOptionsFour)];
    
    NSLog(@"%s-%s-%s-%s-%s",@encode(int),@encode(id),@encode(NSString),@encode(SEL),@encode(void));
    
    LWRuntimePersonCache *personCache = [[LWRuntimePersonCache alloc]init];
    [personCache test];
    [personCache test];
    
    LWRuntimePerson *objP = [[LWRuntimePerson alloc]init];
    [objP personTest];
    objc_msgSend(objP,sel_registerName("personTest"));
    //消息接受者(receiver):objP
    //消息名称：personTest
    // OC的方法调用：消息机制，给方法调用者发送消息
    
    //动态添加方法。
    [objP test];
    [objP test];
    [LWRuntimePerson testC];
    //消息转发
    [objP testMessage];
    [objP testMessage];
    
    [objP testForward];
    [objP testForward];
    
    [[[LWRuntimeAPI alloc]init] test];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
