//
//  LWSuperViewController.m
//  LWTestDemo
//
//  Created by linwei on 2021/6/22.
//

#import "LWSuperViewController.h"
#import "LWSuperPerson.h"

@interface LWSuperViewController ()

@end

@implementation LWSuperViewController
/*
    1.print为什么能够调用成功？
 
    2.为什么self.name变成了LWSuperViewController等其他内容？
 
 */
- (void)viewDidLoad {
    /**[super viewDidLoad] 本质
     objc_msgSendSuper({
         self,
         [UIViewController Class]
     },@selector(viewDidLoad))
     */
    [super viewDidLoad];
    
//    NSString *test = @"123";
    id cls = [LWSuperPerson class];
    
    void *obj = &cls;
    
    [(__bridge id)obj print];
}

@end
