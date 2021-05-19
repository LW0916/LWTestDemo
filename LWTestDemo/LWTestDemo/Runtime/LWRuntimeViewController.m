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

#import <objc/runtime.h>

@interface LWRuntimeViewController ()

@end

@implementation LWRuntimeViewController

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
    // Do any additional setup after loading the view.
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
