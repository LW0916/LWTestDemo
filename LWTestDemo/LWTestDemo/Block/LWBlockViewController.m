//
//  LWBlockViewController.m
//  LWTestDemo
//
//  Created by linwei on 2021/3/8.
//

#import "LWBlockViewController.h"

@interface LWBlockViewController ()

@end

@implementation LWBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int age= 10;
    void (^block)(int,int) = ^(int a,int b){
        NSLog(@"this is block --%d",age);
    };
    block(10,20);
}

@end
